## Rails 6.0.3.2 (June 17, 2020)

- No changes.

## Rails 6.0.3.1 (May 18, 2020)

- No changes.

## Rails 6.0.3 (May 06, 2020)

- No changes.

## Rails 6.0.2.2 (March 19, 2020)

- No changes.

## Rails 6.0.3.2 (December 18, 2019)

- No changes.

## Rails 6.0.2 (December 13, 2019)

- Fix ActionMailer assertions don't work for parameterized mail with legacy delivery job.

  _bogdanvlviv_

## Rails 6.0.1 (November 5, 2019)

- No changes.

## Rails 6.0.0 (August 16, 2019)

- No changes.

## Rails 6.0.0.rc2 (July 22, 2019)

- No changes.

## Rails 6.0.0.rc1 (April 24, 2019)

- No changes.

## Rails 6.0.0.beta3 (March 11, 2019)

- No changes.

## Rails 6.0.0.beta2 (February 25, 2019)

- No changes.

## Rails 6.0.0.beta1 (January 18, 2019)

- Deprecate `ActionMailer::Base.receive` in favor of [Action Mailbox](https://github.com/rails/rails/tree/master/actionmailbox).

  _George Claghorn_

- Add `MailDeliveryJob` for delivering both regular and parameterized mail. Deprecate using `DeliveryJob` and `Parameterized::DeliveryJob`.

  _Gannon McGibbon_

- Fix ActionMailer assertions not working when a Mail defines
  a custom delivery job class

  _Edouard Chin_

- Mails with multipart `format` blocks with implicit render now also check for
  a template name in options hash instead of only using the action name.

  _Marcus Ilgner_

- `ActionDispatch::IntegrationTest` includes `ActionMailer::TestHelper` module by default.

  _Ricardo Díaz_

- Add `perform_deliveries` to a payload of `deliver.action_mailer` notification.

  _Yoshiyuki Kinjo_

- Change delivery logging message when `perform_deliveries` is false.

  _Yoshiyuki Kinjo_

- Allow call `assert_enqueued_email_with` with no block.

  Example:

  ```
  def test_email
    ContactMailer.welcome.deliver_later
    assert_enqueued_email_with ContactMailer, :welcome
  end

  def test_email_with_arguments
    ContactMailer.welcome("Hello", "Goodbye").deliver_later
    assert_enqueued_email_with ContactMailer, :welcome, args: ["Hello", "Goodbye"]
  end
  ```

  _bogdanvlviv_

- Ensure mail gem is eager autoloaded when eager load is true to prevent thread deadlocks.

  _Samuel Cochran_

- Perform email jobs in `assert_emails`.

  _Gannon McGibbon_

- Add `Base.unregister_observer`, `Base.unregister_observers`,
  `Base.unregister_interceptor`, `Base.unregister_interceptors`,
  `Base.unregister_preview_interceptor` and `Base.unregister_preview_interceptors`.
  This makes it possible to dynamically add and remove email observers and
  interceptors at runtime in the same way they're registered.

  _Claudio Ortolina_, _Kota Miyake_

- Rails 6 requires Ruby 2.5.0 or newer.

  _Jeremy Daer_, _Kasper Timm Hansen_

Please check [5-2-stable](https://github.com/rails/rails/blob/5-2-stable/actionmailer/CHANGELOG.md) for previous changes.
