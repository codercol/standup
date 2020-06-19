## Rails 6.0.3.2 (June 17, 2020)

- No changes.

## Rails 6.0.3.1 (May 18, 2020)

- [CVE-2020-8162] Include Content-Length in signature for ActiveStorage direct upload

## Rails 6.0.3 (May 06, 2020)

- No changes.

## Rails 6.0.2.2 (March 19, 2020)

- No changes.

## Rails 6.0.3.2 (December 18, 2019)

- No changes.

## Rails 6.0.2 (December 13, 2019)

- No changes.

## Rails 6.0.1 (November 5, 2019)

- `ActiveStorage::AnalyzeJob`s are discarded on `ActiveRecord::RecordNotFound` errors.

  _George Claghorn_

- Blobs are recorded in the database before being uploaded to the service.
  This fixes that generated blob keys could silently collide, leading to
  data loss.

  _Julik Tarkhanov_

## Rails 6.0.0 (August 16, 2019)

- No changes.

## Rails 6.0.0.rc2 (July 22, 2019)

- No changes.

## Rails 6.0.0.rc1 (April 24, 2019)

- Don't raise when analyzing an image whose type is unsupported by ImageMagick.

  Fixes #36065.

  _Guilherme Mansur_

- Permit generating variants of BMP images.

  _Younes Serraj_

## Rails 6.0.0.beta3 (March 11, 2019)

- No changes.

## Rails 6.0.0.beta2 (February 25, 2019)

- No changes.

## Rails 6.0.0.beta1 (January 18, 2019)

- [Rename npm package](https://github.com/rails/rails/pull/34905) from
  [`activestorage`](https://www.npmjs.com/package/activestorage) to
  [`@rails/activestorage`](https://www.npmjs.com/package/@rails/activestorage).

  _Javan Makhmali_

- Replace `config.active_storage.queue` with two options that indicate which
  queues analysis and purge jobs should use, respectively:

  - `config.active_storage.queues.analysis`
  - `config.active_storage.queues.purge`

  `config.active_storage.queue` is preferred over the new options when it's
  set, but it is deprecated and will be removed in Rails 6.1.

  _George Claghorn_

- Permit generating variants of TIFF images.

  _Luciano Sousa_

- Use base36 (all lowercase) for all new Blob keys to prevent
  collisions and undefined behavior with case-insensitive filesystems and
  database indices.

  _Julik Tarkhanov_

- It doesn’t include an `X-CSRF-Token` header if a meta tag is not found on
  the page. It previously included one with a value of `undefined`.

  _Cameron Bothner_

- Fix `ArgumentError` when uploading to amazon s3

  _Hiroki Sanpei_

- Add progressive JPG to default list of variable content types

  _Maurice Kühlborn_

- Add `ActiveStorage.routes_prefix` for configuring generated routes.

  _Chris Bisnett_

- `ActiveStorage::Service::AzureStorageService` only handles specifically
  relevant types of `Azure::Core::Http::HTTPError`. It previously obscured
  other types of `HTTPError`, which is the azure-storage gem’s catch-all
  exception class.

  _Cameron Bothner_

- `ActiveStorage::DiskController#show` generates a 404 Not Found response when
  the requested file is missing from the disk service. It previously raised
  `Errno::ENOENT`.

  _Cameron Bothner_

- `ActiveStorage::Blob#download` and `ActiveStorage::Blob#open` raise
  `ActiveStorage::FileNotFoundError` when the corresponding file is missing
  from the storage service. Services translate service-specific missing object
  exceptions (e.g. `Google::Cloud::NotFoundError` for the GCS service and
  `Errno::ENOENT` for the disk service) into
  `ActiveStorage::FileNotFoundError`.

  _Cameron Bothner_

- Added the `ActiveStorage::SetCurrent` concern for custom Active Storage
  controllers that can't inherit from `ActiveStorage::BaseController`.

  _George Claghorn_

- Active Storage error classes like `ActiveStorage::IntegrityError` and
  `ActiveStorage::UnrepresentableError` now inherit from `ActiveStorage::Error`
  instead of `StandardError`. This permits rescuing `ActiveStorage::Error` to
  handle all Active Storage errors.

  _Andrei Makarov_, _George Claghorn_

- Uploaded files assigned to a record are persisted to storage when the record
  is saved instead of immediately.

  In Rails 5.2, the following causes an uploaded file in `params[:avatar]` to
  be stored:

  ```ruby
  @user.avatar = params[:avatar]
  ```

  In Rails 6, the uploaded file is stored when `@user` is successfully saved.

  _George Claghorn_

- Add the ability to reflect on defined attachments using the existing
  ActiveRecord reflection mechanism.

  _Kevin Deisz_

- Variant arguments of `false` or `nil` will no longer be passed to the
  processor. For example, the following will not have the monochrome
  variation applied:

  ```ruby
    avatar.variant(monochrome: false)
  ```

  _Jacob Smith_

- Generated attachment getter and setter methods are created
  within the model's `GeneratedAssociationMethods` module to
  allow overriding and composition using `super`.

  _Josh Susser_, _Jamon Douglas_

- Add `ActiveStorage::Blob#open`, which downloads a blob to a tempfile on disk
  and yields the tempfile. Deprecate `ActiveStorage::Downloading`.

  _David Robertson_, _George Claghorn_

- Pass in `identify: false` as an argument when providing a `content_type` for
  `ActiveStorage::Attached::{One,Many}#attach` to bypass automatic content
  type inference. For example:

  ```ruby
    @message.image.attach(
      io: File.open('/path/to/file'),
      filename: 'file.pdf',
      content_type: 'application/pdf',
      identify: false
    )
  ```

  _Ryan Davidson_

- The Google Cloud Storage service properly supports streaming downloads.
  It now requires version 1.11 or newer of the google-cloud-storage gem.

  _George Claghorn_

- Use the [ImageProcessing](https://github.com/janko-m/image_processing) gem
  for Active Storage variants, and deprecate the MiniMagick backend.

  This means that variants are now automatically oriented if the original
  image was rotated. Also, in addition to the existing ImageMagick
  operations, variants can now use `:resize_to_fit`, `:resize_to_fill`, and
  other ImageProcessing macros. These are now recommended over raw `:resize`,
  as they also sharpen the thumbnail after resizing.

  The ImageProcessing gem also comes with a backend implemented on
  [libvips](http://jcupitt.github.io/libvips/), an alternative to
  ImageMagick which has significantly better performance than
  ImageMagick in most cases, both in terms of speed and memory usage. In
  Active Storage it's now possible to switch to the libvips backend by
  changing `Rails.application.config.active_storage.variant_processor` to
  `:vips`.

  _Janko Marohnić_

- Rails 6 requires Ruby 2.5.0 or newer.

  _Jeremy Daer_, _Kasper Timm Hansen_

Please check [5-2-stable](https://github.com/rails/rails/blob/5-2-stable/activestorage/CHANGELOG.md) for previous changes.
