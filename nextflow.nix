{ buildFHSUserEnv, stdenv, fetchurl, openjdk }:
let
  nextflow = stdenv.mkDerivation {
    name = "nextflow";
    src = fetchurl {
      url = "https://get.nextflow.io";
      sha256 = "sha256-uRVaJ+Ee75IHOc4Q214cYklRqoMA4rddTkPooofVZqY=";
    };
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/bin
      install -m755 $src $out/bin/nextflow
    '';

  };

in
buildFHSUserEnv {
  name = "nextflow";
  targetPkgs = pkgs: [ nextflow openjdk ];
  runScript = "nextflow";
}
