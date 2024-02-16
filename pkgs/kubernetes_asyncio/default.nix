{
  lib,
  buildPythonPackage,
  buildPythonApplication,
  fetchPypi,
  setuptools,
  certifi,
  six,
  python-dateutil,
  urllib3,
  pyyaml,
  aiohttp,
}:
buildPythonPackage rec {
  pname = "kubernetes_asyncio";
  version = "29.0.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-mf8f6k3wYq23puSJYq0lBEWRZf/XVCATvD1y2as4F74=";
  };
  doCheck = true;

  nativeBuildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    certifi
    six
    python-dateutil
    urllib3
    pyyaml
    aiohttp
  ];
  meta = with lib; {
    description = "Asynchronous (AsyncIO) client library for the Kubernetes API.";
    homepage = "https://github.com/tomplus/kubernetes_asyncio/";
    license = licenses.asl20;
  };
}
