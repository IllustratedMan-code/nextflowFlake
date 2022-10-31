{ lib
, stdenv
, fetchurl
, makeWrapper
, jre
, wget
, which
, gnused
, gawk
, coreutils
, buildFHSUserEnv
}:
let
  nextflow = stdenv.mkDerivation rec {
    name = "nextflow";
    version = "22.10.0";
    src = fetchurl {
      url = "https://github.com/nextflow-io/nextflow/releases/download/v${version}/nextflow-${version}-all";
      sha256 = "sha256-pxS+68tUTWwUAoYhk0CpRA1BLSrVemkd4PBhBoQgToM=";
    };
    dontUnpack = true;
    nativeBuildInputs = [ makeWrapper ];
    buildInputs = [ jre wget which gnused gawk coreutils ];
    installPhase = ''
            runHook preInstall
            mkdir -p $out/bin
            install -m755 $src $out/bin/nextflow
      			runHook postInstall
    '';
    postFixup = ''
      				wrapProgram $out/bin/nextflow --prefix PATH : ${lib.makeBinPath buildInputs}
      		'';
    meta = with lib; {
      description = "A DSL for data-driven computational pipelines";
      longDescription = ''
        							Nextflow is a bioinformatics workflow manager that enables the development of portable and reproducible workflows.
        							It supports deploying workflows on a variety of execution platforms including local, HPC schedulers, AWS Batch, Google Cloud Life Sciences, and Kubernetes.
        							Additionally, it provides support for manage your workflow dependencies through built-in support for Conda, Docker, Singularity, and Modules.
        						'';
      homepage = "https://www.nextflow.io/";
      changelog = "https://github.com/nextflow-io/nextflow/releases";
      license = licenses.asl20;
      maintainers = [ maintainers.Etjean ];
      mainProgram = "nextflow";
      platforms = platforms.unix;
    };
  };

in
buildFHSUserEnv {
  name = "nextflow";
  targetPkgs = pkgs: [ nextflow ];
  runScript = "nextflow";
}
