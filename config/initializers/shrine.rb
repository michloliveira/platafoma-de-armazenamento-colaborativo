require "shrine"
require "shrine/storage/file_system"

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), # temporary
  store: Shrine::Storage::FileSystem.new("public", prefix: "uploads/store"),       # permanent
}

Shrine.plugin :activerecord           # Load Active Record integration
Shrine.plugin :cached_attachment_data # For retaining cached file on form redisplays
Shrine.plugin :determine_mime_type
