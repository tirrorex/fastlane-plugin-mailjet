require 'fastlane/action'
require 'mailjet'

module Fastlane
  module Actions
    class MailjetAction < Action
      def self.is_supported?(platform)
        platform == :ios
      end

      def self.run(options)
        Actions.verify_gem!('mailjet')
        require 'mailjet'
        mailjetunit(options)
      end

      def self.description
        "Send a custom message to an email group with mailjet"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :api_key,
                                       env_name: "MAILJET_APIKEY",
                                       description: "Public api key for mailjet"),
          FastlaneCore::ConfigItem.new(key: :secret_key,
                                       env_name: "MAILJET_PRIVATEKEY",
                                       description: "Private api key for mailjet") ,
          FastlaneCore::ConfigItem.new(key: :api_version,
                                       env_name: "MAILJET_APIVERSION",
                                       description: "API version formailjet",
                                       default_value: "v3"),
          FastlaneCore::ConfigItem.new(key: :sender,
                                       env_name: "SENDER",
                                       description: "Object containing sender email and name",
                                       is_string: false),
          FastlaneCore::ConfigItem.new(key: :recipients,
                                       env_name: "RECIPIENTS",
                                       description: "Array of objects containing emails  and names",
                                       is_string: false),
          FastlaneCore::ConfigItem.new(key: :subject,
                                       env_name: "SUBJECT",
                                       description: "Subject of the mail"),
          FastlaneCore::ConfigItem.new(key: :textPart,
                                       env_name: "TEXTPART",
                                       description: "Text part of the mail"),
          FastlaneCore::ConfigItem.new(key: :attachment,
                                       env_name: "MAILJET_ATTACHMENT",
                                       description: "Mail Attachment filenames, either an array or just one string",
                                       optional: true,
                                       is_string: false),
          FastlaneCore::ConfigItem.new(key: :templateLanguage,
                                       env_name: "TEMPLATE_LANGUAGE",
                                       description: "Language of the mail template",
                                       optional: true,
                                      is_string: false),
          FastlaneCore::ConfigItem.new(key: :templateErrorReporting,
                                       env_name: "TEMPLATE_ERROR_REPORTING",
                                       description: "Mail adress for the reporting of error",
                                       optional: true,
                                       is_string: false),
          FastlaneCore::ConfigItem.new(key: :templatEerrorDeliver,
                                       env_name: "TEMPLATE_ERROR_DELIVER",
                                       description: "Deliver error template",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :templateId,
                                       env_name: "TEMPLATEID",
                                       description: "Id of the mail template",
                                       optional: true,
                                       is_string: false),
          FastlaneCore::ConfigItem.new(key: :vars,
                                       env_name: "VARS",
                                       description: "Variables of the mail object",
                                       optional: true,
                                       is_string: false),
        ]
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ["Thibaut noah"]
      end

      def self.mailjetunit(options)
        # initializers/mailjet.rb
        Mailjet.configure do |config|
          config.api_key = options[:api_key]
          config.secret_key = options[:secret_key]
          config.api_version = options[:api_version]
        end
        recipientsArray= options[:recipients].split(/[,;]/).each do |recip|
            hash = {:email => "recipient email"}
        end
          email = { :from_email   => options.dig(:sender, :email),
            :from_name    => options.dig(:sender, :name),
            :subject      => options[:subject],
            :text_part    => options[:textPart],
            :recipients   => recipientsArray,
            :'mj-templatelanguage' => options[:templateLanguage],
            :'mj-templateerrorreporting' => options[:templateErrorReporting],
            :'mj-templateerrordeliver' => options[:templatEerrorDeliver],
            :'mj-templateid' => options[:templateId],
            :vars => options[:vars]
          }
          test = Mailjet::Send.create(email)
      end
    end
  end
end
