default_platform(:ios)

platform :ios do
  desc "Push a new beta build to TestFlight"
  lane :beta do
    # Setup CI environment
    setup_ci if ENV['CI']
    
    # Match certificates and profiles
    match(
      type: "appstore",
      readonly: true,
      git_url: ENV['MATCH_GIT_URL'] || "https://github.com/YOUR_USERNAME/certificates.git"
    )
    
    # Increment build number
    increment_build_number(
      build_number: latest_testflight_build_number + 1,
      xcodeproj: "Runner.xcodeproj"
    )
    
    # Build the app
    build_app(
      workspace: "Runner.xcworkspace",
      scheme: "Runner",
      export_method: "app-store",
      export_options: {
        provisioningProfiles: {
          "com.taabor.app" => "match AppStore com.taabor.app"
        }
      },
      clean: true
    )
    
    # Upload to TestFlight
    upload_to_testflight(
      skip_waiting_for_build_processing: true,
      notify_external_testers: false
    )
    
    # Clean up
    clean_build_artifacts
  end
  
  desc "Deploy to App Store"
  lane :release do
    # Setup CI environment
    setup_ci if ENV['CI']
    
    # Match certificates
    match(
      type: "appstore",
      readonly: true
    )
    
    # Build
    build_app(
      workspace: "Runner.xcworkspace",
      scheme: "Runner",
      export_method: "app-store"
    )
    
    # Upload to App Store
    upload_to_app_store(
      skip_metadata: true,
      skip_screenshots: true,
      submit_for_review: false
    )
  end
end
