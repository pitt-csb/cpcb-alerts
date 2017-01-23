class AppMailer < ApplicationMailer

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to CPCB Alerts')
  end

  def event_reminder(event, schedule)
    @event = event
    get_email_list(@event.category_id)
    case schedule
    when 'week'
      filter_subscribers('week')
    when 'day'
      filter_subscribers('day')
    end
    mail(to: @users.pluck(:email),
        subject: "DCB Reminder: #{@event.title}")
  end

  private

    def get_email_list(category_id)
      case category_id
      when 1
        @users = User.where(:subscribed_to_email => true, :faculty_meetings => true)
      when 2
        @users = User.where(:subscribed_to_email => true, :cpcb_seminars => true)
      when 3
        @users = User.where(:subscribed_to_email => true, :miscellaneous => true)
      when 4
        @users = User.where(:subscribed_to_email => true, :csb_seminars => true)
      else
       @users = User.all
      end
    end

    def filter_subscribers(subscription_option)
      case subscription_option
      when 'day'
        @users = @users.where(:day_before_email => true)
      when 'week'
        @users = @users.where(:week_before_email => true)
      else
        @users
      end
    end

end
