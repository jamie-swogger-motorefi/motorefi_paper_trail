# frozen_string_literal: true

module MotorefiPaperTrail
  module Rails
    # Extensions to rails controllers. Provides convenient ways to pass certain
    # information to the model layer, with `controller_info` and `whodunnit`.
    # Also includes a convenient on/off switch,
    # `motorefi_paper_trail_enabled_for_controller`.
    module Controller
      def self.included(controller)
        controller.before_action(
          :set_motorefi_paper_trail_enabled_for_controller,
          :set_motorefi_paper_trail_controller_info
        )
      end

      protected

      # Returns the user who is responsible for any changes that occur.
      # By default this calls `current_user` and returns the result.
      #
      # Override this method in your controller to call a different
      # method, e.g. `current_person`, or anything you like.
      #
      # @api public
      def user_for_motorefi_paper_trail
        return unless defined?(current_user)
        current_user.try(:id) || current_user
      end

      # Returns any information about the controller or request that you
      # want MotorefiPaperTrail to store alongside any changes that occur.  By
      # default this returns an empty hash.
      #
      # Override this method in your controller to return a hash of any
      # information you need.  The hash's keys must correspond to columns
      # in your `motorefi_versions` table, so don't forget to add any new columns
      # you need.
      #
      # For example:
      #
      #     {:ip => request.remote_ip, :user_agent => request.user_agent}
      #
      # The columns `ip` and `user_agent` must exist in your `motorefi_versions` # table.
      #
      # Use the `:meta` option to
      # `MotorefiPaperTrail::Model::ClassMethods.has_motorefi_paper_trail` to store any extra
      # model-level data you need.
      #
      # @api public
      def info_for_motorefi_paper_trail
        {}
      end

      # Returns `true` (default) or `false` depending on whether MotorefiPaperTrail
      # should be active for the current request.
      #
      # Override this method in your controller to specify when MotorefiPaperTrail
      # should be off.
      #
      # ```
      # def motorefi_paper_trail_enabled_for_controller
      #   # Don't omit `super` without a good reason.
      #   super && request.user_agent != 'Disable User-Agent'
      # end
      # ```
      #
      # @api public
      def motorefi_paper_trail_enabled_for_controller
        ::MotorefiPaperTrail.enabled?
      end

      private

      # Tells MotorefiPaperTrail whether motorefi_versions should be saved in the current
      # request.
      #
      # @api public
      def set_motorefi_paper_trail_enabled_for_controller
        ::MotorefiPaperTrail.request.enabled = motorefi_paper_trail_enabled_for_controller
      end

      # Tells MotorefiPaperTrail who is responsible for any changes that occur.
      #
      # @api public
      def set_motorefi_paper_trail_whodunnit
        if ::MotorefiPaperTrail.request.enabled?
          ::MotorefiPaperTrail.request.whodunnit = user_for_motorefi_paper_trail
        end
      end

      # Tells MotorefiPaperTrail any information from the controller you want to store
      # alongside any changes that occur.
      #
      # @api public
      def set_motorefi_paper_trail_controller_info
        if ::MotorefiPaperTrail.request.enabled?
          ::MotorefiPaperTrail.request.controller_info = info_for_motorefi_paper_trail
        end
      end
    end
  end
end
