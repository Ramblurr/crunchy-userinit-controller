{
  lib,
  buildPythonPackage,
  buildPythonApplication,
  fetchPypi,
  setuptools,
  certvalidator,
  aresponses,
  codecov,
  coverage,
  coveralls,
  freezegun,
  isort,
  lxml,
  mypy,
  pre-commit,
  pyngrok,
  pytest,
  pytest-aiohttp,
  pytest-asyncio,
  pytest-cov,
  pytest-mock,
  pytest-timeout,
  types-pyyaml,
  setuptools-scm,
  python-json-logger,
  iso8601,
  click,
}:
buildPythonPackage rec {
  pname = "kopf";
  version = "1.37.1";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-84gpy3AteIq1NuzVHxDYMXW5cYdK8dbIF4qGTPmvTs4=";
  };
  doCheck = true;

  nativeBuildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    certvalidator
    aresponses
    codecov
    coverage
    coveralls
    freezegun
    isort
    isort
    lxml
    mypy
    pre-commit
    pyngrok
    pytest
    pytest-aiohttp
    pytest-asyncio
    pytest-cov
    pytest-mock
    pytest-timeout
    types-pyyaml
    setuptools-scm
    python-json-logger
    iso8601
    click
  ];
  meta = with lib; {
    description = "Kubernetes Operator Pythonic Framework";
    homepage = "https://github.com/nolar/kopf";
    license = licenses.mit;
  };
}
