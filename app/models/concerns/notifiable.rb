module Notifiable
  extend ActiveSupport::Concern

  included do
    has_many :notifications, as: :notifiable, dependent: :destroy
    class << self; attr_accessor :interesants end # Class-level instance variable для хранения интересантов
  end

  module ClassMethods
    
    # Возможность установить дефолтных интересантов при объявлении класса методом interesants.
    # Без параметров возвращает текущий список интересантов. При посылке нотификакий этот список можно будет изменить.
    #
    # @param inter список интересантов
    #
    # @example
    #   class Foo < ActiveRecord::Base
    #      interesants :approver, :executor
    #   end
    def default_interesants *inter
      if inter.count
        self.interesants = inter
      else
        return self.interesants
      end
    end

    def notifications_for user
      Notification.where(user_id: user.id, notifiable_type: self.to_s)
    end
  end

  # Посылаем уведомления
  # @param options
  #   - @param only [Array] каким типам интересантов посылать. По-умолчанию установлены те, которые задаются методом interesants
  #   - @param except [Array] каким типам интересантов не посылать. По-умолчанию: []
  #   - @param exclude [Array] of [User] каким пользователям не посылать. По-умолчанию: []
  # @example
  #   obj.notify_interesants only: [:approver], exclude: current_user # Посылаем уведомление только контрольному лицу, если контрольное лицо не текущий юзер
  #   obj.notify_interesants except: [:creator], exclude: doc.creator # Посылаем уведомление согласующим, исполнителю и контрольному лицу; если кто-то из них создатель - ему не посылаем
  # @see User
  def notify_interesants options = {}
    # Options defaults
    options.reverse_merge! only: self.class.interesants, except: [], exclude: []
    
    # Оборачиваем параметры в массивы, если переданы просто символами
    options.each {|k, option| options[k] = [option] unless option.class == Array}

    # Убираем те типы, которые не нужны
    options[:only].reject! {|type| options[:except].include? type}

    # Наполняем массив объектами типа User
    interested = []
    options[:only].each do |in_sym| 
      obj = self.send(in_sym)
      if obj.is_a? Array
        obj.each do |elem|
         interested << elem if elem.instance_of? User 
       end
      else
        interested << obj if obj.instance_of? User
      end
    end

    interested.reject! {|user| options[:exclude].include? user} # Не отправляем уведомления тем, кто в списке exclude
    interested.uniq.each { |user| self.notifications.find_or_create_by_user_id(user.id) } # Создаем нотификацию, если ее еще нет
  end

  # Удаляем нотификацию о текущем объекте для всех пользователей (или конкретного пользователя)
  # @param options
  #   - @param for [User] Для какого пользователя удалить
  # @example
  #   obj.clear_notifications # для всех
  #   obj.clear_notifications for: current_user # только для текущего пользователя
  # @see User
  def clear_notifications options = {}
    (options[:for] ? self.notifications.where(user_id: options[:for].id) : self.notifications).destroy_all
  end

  # Есть ли у объекта нотификация для конкретного пользователя?
  # @param user [User] Пользователь
  # @example
  #   obj.has_notifications_for? current_user
  # @see User
  def has_notification_for? user
    self.notifications.where(user_id: user.id).count > 0 ? true : false
  end
end