## Rails 6.0.3.2 (June 17, 2020)

- No changes.

## Rails 6.0.3.1 (May 18, 2020)

- No changes.

## Rails 6.0.3 (May 06, 2020)

- While using `perform_enqueued_jobs` test helper enqueued jobs must be stored for the later check with
  `assert_enqueued_with`.

  _Dmitry Polushkin_

- Add queue name support to Que adapter

  _Brad Nauta_, _Wojciech Wnętrzak_

## Rails 6.0.2.2 (March 19, 2020)

- No changes.

## Rails 6.0.3.2 (December 18, 2019)

- No changes.

## Rails 6.0.2 (December 13, 2019)

- Allow Sidekiq access to the underlying job class.

  By having access to the Active Job class, Sidekiq can get access to any `sidekiq_options` which
  have been set on that Active Job type and serialize those options into Redis.

  https://github.com/mperham/sidekiq/blob/master/Changes.md#60

  _Mike Perham_

## Rails 6.0.1 (November 5, 2019)

- No changes.

## Rails 6.0.0 (August 16, 2019)

- `assert_enqueued_with` and `assert_performed_with` can now test jobs with relative delay.

  _Vlado Cingel_

## Rails 6.0.0.rc2 (July 22, 2019)

- No changes.

## Rails 6.0.0.rc1 (April 24, 2019)

- Use individual execution counters when calculating retry delay.

  _Patrik Bóna_

- Make job argument assertions with `Time`, `ActiveSupport::TimeWithZone`, and `DateTime` work by dropping microseconds. Microsecond precision is lost during serialization.

  _Gannon McGibbon_

## Rails 6.0.0.beta3 (March 11, 2019)

- No changes.

## Rails 6.0.0.beta2 (February 25, 2019)

- No changes.

## Rails 6.0.0.beta1 (January 18, 2019)

- Return false instead of the job instance when `enqueue` is aborted.

  This will be the behavior in Rails 6.1 but it can be controlled now with
  `config.active_job.return_false_on_aborted_enqueue`.

  _Kir Shatrov_

- Keep executions for each specific declaration

  Each `retry_on` declaration has now its own specific executions counter. Before it was
  shared between all executions of a job.

  _Alberto Almagro_

- Allow all assertion helpers that have a `only` and `except` keyword to accept
  Procs.

  _Edouard Chin_

- Restore `HashWithIndifferentAccess` support to `ActiveJob::Arguments.deserialize`.

  _Gannon McGibbon_

- Include deserialized arguments in job instances returned from
  `assert_enqueued_with` and `assert_performed_with`

  _Alan Wu_

- Allow `assert_enqueued_with`/`assert_performed_with` methods to accept
  a proc for the `args` argument. This is useful to check if only a subset of arguments
  matches your expectations.

  _Edouard Chin_

- `ActionDispatch::IntegrationTest` includes `ActiveJob::TestHelper` module by default.

  _Ricardo Díaz_

- Added `enqueue_retry.active_job`, `retry_stopped.active_job`, and `discard.active_job` hooks.

  _steves_

- Allow `assert_performed_with` to be called without a block.

  _bogdanvlviv_

- Execution of `assert_performed_jobs`, and `assert_no_performed_jobs`
  without a block should respect passed `:except`, `:only`, and `:queue` options.

  _bogdanvlviv_

- Allow `:queue` option to job assertions and helpers.

  _bogdanvlviv_

- Allow `perform_enqueued_jobs` to be called without a block.

  Performs all of the jobs that have been enqueued up to this point in the test.

  _Kevin Deisz_

- Move `enqueue`/`enqueue_at` notifications to an around callback.

  Improves timing accuracy over the old after callback by including
  time spent writing to the adapter's IO implementation.

  _Zach Kemp_

- Allow call `assert_enqueued_with` with no block.

  Example:

  ```
  def test_assert_enqueued_with
    MyJob.perform_later(1,2,3)
    assert_enqueued_with(job: MyJob, args: [1,2,3], queue: 'low')

    MyJob.set(wait_until: Date.tomorrow.noon).perform_later
    assert_enqueued_with(job: MyJob, at: Date.tomorrow.noon)
  end
  ```

  _bogdanvlviv_

- Allow passing multiple exceptions to `retry_on`, and `discard_on`.

  _George Claghorn_

- Pass the error instance as the second parameter of block executed by `discard_on`.

  Fixes #32853.

  _Yuji Yaginuma_

- Remove support for Qu gem.

  Reasons are that the Qu gem wasn't compatible since Rails 5.1,
  gem development was stopped in 2014 and maintainers have
  confirmed its demise. See issue #32273

  _Alberto Almagro_

- Add support for timezones to Active Job.

  Record what was the current timezone in effect when the job was
  enqueued and then restore when the job is executed in same way
  that the current locale is recorded and restored.

  _Andrew White_

- Rails 6 requires Ruby 2.5.0 or newer.

  _Jeremy Daer_, _Kasper Timm Hansen_

- Add support to define custom argument serializers.

  _Evgenii Pecherkin_, _Rafael Mendonça França_

Please check [5-2-stable](https://github.com/rails/rails/blob/5-2-stable/activejob/CHANGELOG.md) for previous changes.
