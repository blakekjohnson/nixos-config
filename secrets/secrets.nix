let
  blakeJLab = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMJHnSMjnCnbAjFb8U5kMKZ7wu4BxOxYPC1tUmlcW7bY";
  labSystem = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOYIfWDhfinfKmsc6YO+14KKgK5W5waTnGK1oWrNaut0";
in
{
  "nextcloud.age".publicKeys = [ blakeJLab labSystem ];
}
