{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    # Adopt new XDG default (stateVersion < 26.05 otherwise uses legacy ~/.mozilla/firefox)
    configPath = "${config.xdg.configHome}/mozilla/firefox";

    policies = {
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableFirefoxScreenshots = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      OfferToSaveLoginsDefault = false;
      PasswordManagerEnabled = false;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DNSOverHTTPS = {
        Enabled = true;
        Locked = true;
        ProviderURL = "https://mozilla.cloudflare-dns.com/dns-query";
      };
      Preferences = {
        "dom.security.https_only_mode" = {
          Value = true;
          Status = "locked";
        };
        "dom.security.https_only_mode_ever_enabled" = {
          Value = true;
          Status = "locked";
        };
      };
    };

    profiles.irwan = {
      id = 0;
      isDefault = true;
      name = "irwan";

      settings = {
        # Telemetry
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.server" = "data:,";
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.coverage.opt-out" = true;
        "toolkit.coverage.endpoint.base" = "";
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "browser.ping-centre.telemetry" = false;
        "breakpad.reportURL" = "";
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;

        # New tab / Activity Stream
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
        "browser.newtabpage.activity-stream.discoverystream.spocs.personalized" = false;

        # Privacy & tracking
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.trackingprotection.cryptomining.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.emailtracking.enabled" = true;
        "privacy.trackingprotection.pbmode.enabled" = true;
        "privacy.donottrackheader.enabled" = true;
        "network.cookie.cookieBehavior" = 5;
        "dom.security.https_only_mode" = true;
        "dom.security.https_only_mode_ever_enabled" = true;
        "network.http.referer.XOriginPolicy" = 2;
        "network.http.referer.XOriginTrimmingPolicy" = 2;
        "browser.send_pings" = false;
        "browser.urlbar.suggest.searches" = false;
        "browser.urlbar.suggest.topsites" = false;

        # DoH via Cloudflare
        "network.trr.mode" = 3;
        "network.trr.uri" = "https://mozilla.cloudflare-dns.com/dns-query";
        "network.trr.custom_uri" = "https://mozilla.cloudflare-dns.com/dns-query";
        "network.trr.allow-rfc1918" = false;

        # Pocket / recommendation / discovery
        "extensions.pocket.enabled" = false;
        "browser.discovery.enabled" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "browser.topsites.contile.enabled" = false;

        # Disable VP8/VP9 (ffvpx) and AV1 codecs
        "media.ffvpx.enabled" = false;
        "media.av1.enabled" = false;
        "media.rdd-vpx.enabled" = true;
        "media.hardware-video-encoding.enabled" = true;
        "media.mp4.enabled" = true;

        # WebRender
        "gfx.webrender.all" = true;
        "gfx.webrender.compositor" = true;
        "layers.acceleration.force-enabled" = true;
        "widget.dmabuf.force-enabled" = true;

        # Auto-enable extensions without manual approval
        "extensions.autoDisableScopes" = 0;

        # Misc
        "browser.aboutConfig.showWarning" = false;
        "signon.autofillForms" = false;
        "signon.rememberSignons" = false;
        "browser.formfill.enable" = false;
      };

      extensions = {
        force = true;
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          proton-pass
          vimium-c
          stylus
          darkreader
          # Required by the catppuccin module to apply the theme (Firefox Color)
          firefox-color
          multi-account-containers
          youtube-recommended-videos
          sponsorblock
        ];
      };
    };
  };
}
