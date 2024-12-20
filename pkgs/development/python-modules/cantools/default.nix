{
  lib,
  argparse-addons,
  bitstruct,
  buildPythonPackage,
  python-can,
  crccheck,
  diskcache,
  fetchPypi,
  matplotlib,
  parameterized,
  pytestCheckHook,
  pythonOlder,
  setuptools,
  setuptools-scm,
  textparser,
}:

buildPythonPackage rec {
  pname = "cantools";
  version = "39.4.11";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-C3vYiiNrst39faXdcTBY6Xt0kYXp0SV0E7J71M/n2Co=";
  };

  nativeBuildInputs = [
    setuptools
    setuptools-scm
  ];

  propagatedBuildInputs = [
    argparse-addons
    bitstruct
    python-can
    crccheck
    diskcache
    textparser
  ];

  optional-dependencies.plot = [ matplotlib ];

  nativeCheckInputs = [
    parameterized
    pytestCheckHook
  ] ++ optional-dependencies.plot;

  pythonImportsCheck = [ "cantools" ];

  meta = with lib; {
    description = "Tools to work with CAN bus";
    mainProgram = "cantools";
    homepage = "https://github.com/cantools/cantools";
    changelog = "https://github.com/cantools/cantools/releases/tag/${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ gray-heron ];
  };
}
