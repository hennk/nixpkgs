{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonOlder
, pytestCheckHook
, pythonRelaxDepsHook
, poetry-core
, httpx
, pydicom
}:

buildPythonPackage rec {
  pname = "pyorthanc";
  version = "1.15.0";
  disabled = pythonOlder "3.8";

  format = "pyproject";

  src = fetchFromGitHub {
    owner = "gacou54";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-2F5yXWqOwQM1i0AgCCr1j98jpZLA2D919Iex9WjKLuw=";
  };

  nativeBuildInputs = [ pythonRelaxDepsHook poetry-core ];

  propagatedBuildInputs = [ httpx pydicom ];

  pythonRelaxDeps = [
    "httpx"
  ];

  doCheck = false;  # requires orthanc server (not in Nixpkgs)

  pythonImportsCheck = [
    "pyorthanc"
  ];

  meta = with lib; {
    description = "Python library that wraps the Orthanc REST API";
    homepage = "https://github.com/gacou54/pyorthanc";
    changelog = "https://github.com/gacou54/pyorthanc/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ bcdarwin ];
  };
}
