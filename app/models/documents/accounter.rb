class Documents::Accounter

  def self.sign(accountable)
    document = accountable.document
    document.approved_at = Time.now
    document.serial_number = Document.serial_number_for(document)
    document.save(false) #do not validate the record
  end

end
