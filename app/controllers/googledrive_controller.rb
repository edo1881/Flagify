$session=nil
class GoogledriveController < ApplicationController
    def googledrive
      credentials = Google::Auth::UserRefreshCredentials.new(
        client_id: "11263900263-k9m8i136qabf46k8osovupg6icgab29d.apps.googleusercontent.com",
        client_secret: "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",
        scope: [
          "https://www.googleapis.com/auth/drive",
          "https://spreadsheets.google.com/feeds/",
        ],
        additional_parameters: { "access_type" => "offline" },
        redirect_uri: "https://developers.google.com/oauthplayground")
      auth_url = credentials.authorization_uri
      credentials.refresh_token = "1//04c-NdGqN7S0GCgYIARAAGAQSNwF-L9IrXiQ0y2ptOx4b7LlUArPZwwW92hRsrkB0bfbCW-O0cdlP8-HWXtk3V8zalxkGS-r8zws"
      credentials.fetch_access_token!
      $session = GoogleDrive::Session.from_credentials(credentials) 
    end
end