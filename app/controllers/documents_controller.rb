# coding: utf-8

class DocumentsController < ApplicationController
  layout 'documents'
  helper_method :sort_column, :sort_direction
  # collection
  
  before_filter :authorize, :only => :edit
  
  def index
    # check if user can view confindetnial documents
    # code since lines from 10 to 14 dont usage in this action, maybe delete them?
    if current_user.has_permission?(5)
      documents = Document.all
    else
      documents = Document.not_confidential
    end
    organization = current_user.organization_id
    current_user_id = current_user.id
    
    #default scope
    if params[:status_sort]
      direction = params[:direction]
      sort_type = "opened #{direction}", "sent #{direction}", "approved #{direction}", "prepared #{direction}"
    else
      sort_type = sort_column + " " + sort_direction
    end
    
    documents = Document.text_search(params[:query])
                .not_deleted.not_archived.not_draft
                .order(sort_type)
                .where{(sent == true) & (organization_id == organization) | 
                  (sender_organization_id == organization) & (user_id == current_user_id) | 
                  (sender_organization_id == organization) & (approver_id == current_user_id) | 
                  (approved == true) & (sender_organization_id == organization)}

    @documents = if params[:type] == 'mails'
      documents.mails # mails
    elsif params[:type] == 'writs'
      documents.writs # writs
    else
      documents # any other case
    end  
    
    # @documents = @documents.paginate(:per_page => 20, :page => params[:page])
    
    @controller = params[:controller]
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def drafts    
    @documents = Document.not_deleted.not_archived.order("created_at DESC").draft.where(:user_id => current_user.id)
    @documents = @documents.paginate(:per_page => 20, :page => params[:page])
  end
  
  def batch
    Document.find(params[:document_ids]).each do |d|
      if params[:prepare]
        if for_approve?(d) #what is this method?
          d.update_attributes(prepared: true, draft: false)
          flash[:notice] = t('documents_updated')
        else
          d.reject
          flash[:notice] = t('access_denied')
        end
      elsif params[:approve]
        d.update_attributes!(approved: true, draft: false, approved_date: Time.now, date: Time.now, sn: "D #{d.id}")
        flash[:notice] = t('documents_updated')
      elsif params[:send]
        d.update_attributes(sent: true, sent_date: Time.now)
        flash[:notice] = t('documents_updated')
      end
    end
    redirect_to documents_path
  end

  def action_list
   if params[:ids].count > 1
     @approve = @prepare = @send_document = true
     params['ids'].each do |id|
       d = Document.find(id)
       @approve =       @approve && (!d.approved && d.approver_id == current_user.id && d.prepared ? true : false)
       @prepare =       @prepare && (!d.prepared && d.user_id == current_user.id || d.approver_id == current_user.id ? true : false)
       @send_document = @send_document && (!d.sent && d.approved && (d.approver_id == current_user.id ||
                        d.user_id == current_user.id) ? true : false)
     end
     @many = params[:ids]
    else
      d = Document.find(params[:ids])[0]
      @edit = d.user_id == current_user.id && d.prepared == false ? true : false
      @show = d.sent && d.organization_id == current_user.organization_id ||
              d.sender_organization_id == current_user.organization_id && d.user_id == current_user.id ||
              d.sender_organization_id == current_user.organization_id && d.approver_id == current_user.id ||
              d.approved && d.sender_organization_id == current_user.organization_id ? true : false
      @reply =   !d.sent && d.organization_id == current_user.organization_id ? true : false
      @approve = !d.approved && d.approver_id == current_user.id && d.prepared ? true : false
      @prepare = !d.prepared && d.user_id == current_user.id || d.approver_id == current_user.id ? true : false
      @create_draft =  !d.prepared
      @send_document = !d.sent && d.approved && (d.approver_id == current_user.id ||
                        d.user_id == current_user.id) ? true : false
      @document_id =    d.id
      end
  end

  def prepare
    render_text = t('documents_prepared')
    if params[:ids].class == String
      params[:ids] = params[:ids].split(",").map { |s| s.to_i }
      render_text = t('document_prepared')
    end
    params[:ids].each do |id|
      @document = Document.find(id)
      @document.update_attributes(prepared_date: Time.now, prepared: true, draft: false)
    end
    redirect_to documents_path, notice: render_text
  end

  def approve
    render_text = t('documents_approved')
    if params[:ids].class == String
      params[:ids] = params[:ids].split(",").map { |s| s.to_i }
      render_text = t('document_approved')
    end
    params[:ids].each do |id|
      @document = Document.find(id)
      @document.update_attributes(draft: false, approved: true, approved_date: Time.now, date: Time.now, sn: "D" + @document.id.to_s)
    end
    redirect_to documents_path, notice: render_text
  end

  def send_document
    render_text = t('documents_successfully_sent')
    if params[:ids].class == String
      params[:ids] = params[:ids].split(",").map { |s| s.to_i }
      render_text = t('document_successfully_sent')
    end
    params[:ids].each do |id|
      @document = Document.find(id)
      @document.update_attributes(sent: true, sent_date: Time.now)
    end
    redirect_to documents_path, notice: render_text
  end

  # member
  
  def show
    @document = Document.find(params[:id])
    if DocumentConversation.exists?(@document.document_conversation_id)
      @conversation = DocumentConversation.find(@document.document_conversation_id)
      @conversation_documents = @conversation.documents.where('id != ?', @document.id)
    end
    
    if current_user.permissions.exists?('1') && @document.organization_id == current_user.organization_id && @document.opened != true
      @document.opened = true
      @document.opened_date = Time.now
      @document.save
      users = User.where(:organization_id => @document.sender_organization_id)
      users.each do |user|
        OpenNotice.create!(:user_id => user.id, :document_id => @document.id)
      end
    end
    
    @sender_organization = Organization.find(@document.sender_organization_id).title
    @organization = Organization.find(@document.organization_id).title
    if @document.user_id
      if User.exists?(@document.user_id)
        @sender = User.find(@document.user_id).first_name_with_last_name
      end
    end
    if @document.executor_id
      if User.exists?(@document.executor_id)
      @executor = User.find(@document.executor_id).first_name_with_last_name
      end
    end
    
    if @document.approver_id
      if User.exists?(@document.approver_id)
      @approver = User.find(@document.approver_id).first_name_with_last_name
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json {render :json => {:sender_organization => @sender_organization,
                                    :sender_organization_id => @sender_organization_id,
                                    :organization => @organization,
                                    :organization_id => @organization_id,
                                    :title => @document.title,
                                    :sn => @document.sn,
                                    :date => @document.date ? @document.date.strftime('%d.%m.%Y') : @document.date,
                                    :type => t(@document.document_type),
                                    :executor => @executor,
                                    :sender => @sender,
                                    :approver => @approver,
                                    :prepared => @document.prepared,
                                    :prepared_date => @document.prepared_date,
                                    :approved => @document.approved,
                                    :approved_date => @document.approved_date,
                                    :sent => @document.sent,
                                    :sent_date => @document.sent_date,
                                    :opened => @document.opened,
                                    :opened_date => @document.opened_date,
                                    :attachments => @document.document_attachments,
                                    :conversation => @conversation }}
      format.js { @document = @document }
      #format.pdf do
      #  send_data(File.write("document_#{@document.id}.pdf"), :type => "application/pdf")
      #end
      format.pdf do
        pdf = DocumentPdf.new(@document, view_context)
        filename = "document_#{@document.id}.pdf"
        pdf.render_file "tmp/#{filename}"
        send_data pdf.render, filename: "document_#{@document.id}.pdf",
                              type: 'application/pdf',
                              disposition: 'inline'
      end
    end
  end

  def new
    @document = Document.new
    @approvers = User.approvers.where('organization_id = ?', current_user.organization_id)
    @executors = User.where(:organization_id => current_user.organization_id)
    @recipients = User.where('organization_id != ?', current_user.organization_id)
    @documents = Document.all
    @task_list = @document.build_task_list
    
    if params[:type] == nil
      redirect_to documents_path
    end
  end

  def edit
    if @document.user_id != current_user.id || @document.approved == true || @document.approver_id != current_user.id
      redirect_to :back, :alert => t('permission_denied')
    else
      @document = Document.find(params[:id])
      @approvers = User.approvers.where(organization_id: current_user.organization_id)
      @executors = User.where(organization_id: current_user.organization_id)
      @recipients = User.where('organization_id != ?', current_user.organization_id)
      @documents = Document.where('id != ?', @document.id)
    end
  end

  def create
    organizations = params[:document][:organization_ids]
    organizations = organizations.delete_if{ |x| x.empty? }
    organizations.each do |organization|
      document = Document.new(params[:document])
      # document.document_type = params[:type] ? params[:type] : 'mail'
      current_user.documents << document
      document.update_attributes(organization_id: organization, user_id: current_user.id,
                                 sender_organization_id: current_user.organization_id,
                                 executor_id: params[:document][:executor_ids].second,
                                 approver_id: params[:document][:approver_ids].second)
      document.update_attributes(prepared: true, prepared_date: Time.now, draft: false) if params[:prepare]
      assign_organizations_to_tasks(document)
    end
    redirect_to documents_path, notice: t('document_successfully_created')
  end

  def update
    @document = Document.find(params[:id])
    @document.update_attributes(user_id: current_user.id, executor_id: params[:document][:executor_ids].second,
                                approver_id: params[:document][:approver_ids].second)
    @document.update_attributes(prepared: true, draft: false) if params[:prepare]
    @document.update_attributes(prepared: false, draft: true) if params[:to_draft]
    
    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html { redirect_to document_path(@document), notice: t('document_successfully_updated') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end



  
  def callback
    @document = Document.find(params[:id])
    @document.sent = false
    @document.callback = true
    @document.save
    redirect_to documents_url, notice: t('document_called_back')
  end
  
  def execute
    @document = Document.find(params[:id])
    @document.for_confirmation = true
    @document.save    

    respond_to do |format|
      format.html 
      format.json 
    end
  end
  
  
  def archive
    @document = Document.find(params[:id])
    @document.archived = true
    @document.save
    redirect_to :back, notice: t('document_archived')
  end
  
  def delete
    @document = Document.find(params[:id])
    if current_user.organization_id = @document.sender_organization_id && @document.sent == false
      if @document.draft?
        @document.destroy
      else
        @document.deleted = true
        @document.save
      end
      redirect_to documents_path, notice: t('document_deleted')
    else
      redirect_to :back, alert: t('permission_denied')
    end
  end
  
  def copy
    @original_document = Document.find(params[:id]) # find original object
    if @original_document.sender_organization_id == current_user.organization.id    
      @document = Document.new(:organization_id => @original_document.organization_id,
                               :approver_id => @original_document.approver_id,
                               :executor_id => @original_document.executor_id,
                               :title => @original_document.title,
                               :text => @original_document.text,
                               :document_type => @original_document.document_type,
                               :document_attachments => @original_document.document_attachments,
                               :document_ids => @original_document.document_ids)
      @approvers = User.approvers.where("organization_id = ? AND users.id != ?", current_user.organization_id, current_user.id)
      @executors = User.where(:organization_id => current_user.organization_id)
      @recipients = User.where('organization_id != ?', current_user.organization_id)
      @documents = Document.all
      render :new
    else
      redirect_to :back, alert: t('permission_denied')
    end
  end
  
  def reply
    @original_document = Document.find(params[:id])
    @document_conversation = DocumentConversation.where(id: @original_document.document_conversation_id).first_or_create!
    @original_document.update_attribute(:document_conversation_id, @document_conversation.id)
    @approvers = User.approvers.where(organization_id: current_user.organization_id)
    @executors = User.where(organization_id: current_user.organization_id)
    @recipients = User.where(organization_id: current_user.organization_id)
    @documents = Document.all
    @document = Document.new
    if current_user.organization_id != @original_document.sender_organization_id && @original_document.opened?
      render :new
    else
      redirect_to :back, :alert => t('only_mails_from_other_organizations_could_be_answered')
    end
  end
  
  def to_drafts
    @document = Document.find(params[:id])
    @document.prepared = false
    @document.draft = true
    @document.user_id = current_user.id
    @document.save
    redirect_to documents_url, notice: t('document_moved_to_drafts')
  end
  
  # misc
  
  def executor_phone
      @user = User.find(params[:user])
      @field = params[:field]
      respond_to do |format|
         format.js {  }
      end
  end


  private
  
  def sort_column
    Document.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
  
  def check_edit_permission
  end
  
  def authorize
    
  end
  
  def assign_organizations_to_tasks(document)
    if document.task_list
      document.task_list.tasks.each do |task|
        task.deadline = document.deadline
        task.executor_organization_id = document.organization_id
        task.sender_organization_id = document.sender_organization_id
        task.save!
      end
    end
  end
end
