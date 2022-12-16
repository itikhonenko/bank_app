# frozen_string_literal: true

module BaseService
  attr_reader :errors, :result

  module ClassMethods
    # @api public
    # Public: Creates an instance of the current class and calls the <call> method on it.
    #
    # @param [Hash] opts passed from parent service class
    #
    # @return [Object] the instance of the called service
    def call(opts)
      new(opts).call
    end
  end

  # @api public
  # Public: Inserts ClassMethods module at the bottom of the inheritance chain, before the class itself.
  #
  # @param [Class] base the class in which the current module was included
  def self.prepended(base)
    base.extend ClassMethods
  end

  # @api public
  # Public: Executes the same method on the parent class and stores the result in the @result variable.
  #
  # @return [Object] the instance of the called service
  def call
    @errors = []
    @result = super

    self
  end

  # @api public
  # Public: Determines if the service was executed with or without errors.
  #
  # @return [Boolean] true if the service executed without error, false otherwise
  def success?
    errors.blank?
  end

  # @api public
  # Public: Adds an error to the service errors array
  #
  # @param [Symbol] error_key error key to distinguish errors within application
  # @param [String] description error description
  #
  # @return [Array] array that contains errors
  def add_error(error_key, description)
    @errors << { error_key: error_key, description: description }
  end
end
