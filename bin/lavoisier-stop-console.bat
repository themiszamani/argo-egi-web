@REM ----------------------------------------------------------------------------
@REM  Copyright 2001-2006 The Apache Software Foundation.
@REM
@REM  Licensed under the Apache License, Version 2.0 (the "License");
@REM  you may not use this file except in compliance with the License.
@REM  You may obtain a copy of the License at
@REM
@REM       http://www.apache.org/licenses/LICENSE-2.0
@REM
@REM  Unless required by applicable law or agreed to in writing, software
@REM  distributed under the License is distributed on an "AS IS" BASIS,
@REM  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@REM  See the License for the specific language governing permissions and
@REM  limitations under the License.
@REM ----------------------------------------------------------------------------
@REM
@REM   Copyright (c) 2001-2006 The Apache Software Foundation.  All rights
@REM   reserved.

@echo off

set ERROR_CODE=0

:init
@REM Decide how to startup depending on the version of windows

@REM -- Win98ME
if NOT "%OS%"=="Windows_NT" goto Win9xArg

@REM set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" @setlocal

@REM -- 4NT shell
if "%eval[2+2]" == "4" goto 4NTArgs

@REM -- Regular WinNT shell
set CMD_LINE_ARGS=%*
goto WinNTGetScriptDir

@REM The 4NT Shell from jp software
:4NTArgs
set CMD_LINE_ARGS=%$
goto WinNTGetScriptDir

:Win9xArg
@REM Slurp the command line arguments.  This loop allows for an unlimited number
@REM of arguments (up to the command line limit, anyway).
set CMD_LINE_ARGS=
:Win9xApp
if %1a==a goto Win9xGetScriptDir
set CMD_LINE_ARGS=%CMD_LINE_ARGS% %1
shift
goto Win9xApp

:Win9xGetScriptDir
set SAVEDIR=%CD%
%0\
cd %0\..\.. 
set BASEDIR=%CD%
cd %SAVEDIR%
set SAVE_DIR=
goto repoSetup

:WinNTGetScriptDir
set BASEDIR=%~dp0\..

:repoSetup
set REPO=


if "%JAVACMD%"=="" set JAVACMD=java

if "%REPO%"=="" set REPO=%BASEDIR%\lib

set CLASSPATH="%BASEDIR%"\etc;"%REPO%"\lavoisier-service-2.1.2-SNAPSHOT.jar;"%REPO%"\lavoisier-engine-2.1.2-SNAPSHOT.jar;"%REPO%"\lavoisier-configuration-2.1.2-SNAPSHOT.jar;"%REPO%"\xml-template-engine-2.1.2-SNAPSHOT.jar;"%REPO%"\xpath-functions-2.1.2-SNAPSHOT.jar;"%REPO%"\lavoisier-chaining-2.1.2-SNAPSHOT.jar;"%REPO%"\log4j-1.2.12.jar;"%REPO%"\html-template-engine-2.1.2-SNAPSHOT.jar;"%REPO%"\xml-interfaces-2.1.2-SNAPSHOT.jar;"%REPO%"\dom4j-1.6.1.jar;"%REPO%"\lavoisier-gui-admin-2.1.2-SNAPSHOT.jar;"%REPO%"\canl-1.3.0.jar;"%REPO%"\bcprov-jdk16-1.46.jar;"%REPO%"\commons-io-1.4.jar;"%REPO%"\lavoisier-cache-base-2.1.2-SNAPSHOT.jar;"%REPO%"\lavoisier-interfaces-2.1.2-SNAPSHOT.jar;"%REPO%"\xpath-absolute-2.1.2-SNAPSHOT.jar;"%REPO%"\grizzly-http-server-2.2.21.jar;"%REPO%"\grizzly-http-2.2.21.jar;"%REPO%"\grizzly-framework-2.2.21.jar;"%REPO%"\grizzly-rcm-2.2.21.jar;"%REPO%"\lavoisier-cache-basex-2.1.2-SNAPSHOT.jar;"%REPO%"\basex-7.9.jar;"%REPO%"\lavoisier-connector-base-2.1.2-SNAPSHOT.jar;"%REPO%"\lavoisier-connector-config-2.1.2-SNAPSHOT.jar;"%REPO%"\lavoisier-connector-diff-2.1.2-SNAPSHOT.jar;"%REPO%"\xmlunit-1.3.jar;"%REPO%"\lavoisier-connector-grid-2.1.2-SNAPSHOT.jar;"%REPO%"\saga-api-1.1.1.jar;"%REPO%"\lavoisier-connector-remctl-2.1.2-SNAPSHOT.jar;"%REPO%"\remctl-2.2.0.jar;"%REPO%"\slf4j-api-1.6.1.jar;"%REPO%"\commons-pool-1.5.6.jar;"%REPO%"\lavoisier-connector-sql-2.1.2-SNAPSHOT.jar;"%REPO%"\mysql-connector-java-5.1.25.jar;"%REPO%"\postgresql-9.2-1003-jdbc4.jar;"%REPO%"\hsqldb-2.2.9.jar;"%REPO%"\xpath-parser-2.1.2-SNAPSHOT.jar;"%REPO%"\jaxen-1.1.4.jar;"%REPO%"\lavoisier-connector-ssh-2.1.2-SNAPSHOT.jar;"%REPO%"\jsch-0.1.49.jar;"%REPO%"\lavoisier-connector-telnet-2.1.2-SNAPSHOT.jar;"%REPO%"\commons-net-2.0.jar;"%REPO%"\lavoisier-processor-base-2.1.2-SNAPSHOT.jar;"%REPO%"\lavoisier-renderer-base-2.1.2-SNAPSHOT.jar;"%REPO%"\lavoisier-renderer-json-2.1.2-SNAPSHOT.jar;"%REPO%"\jackson-core-2.1.0.jar;"%REPO%"\lavoisier-renderer-pdf-2.1.2-SNAPSHOT.jar;"%REPO%"\itextpdf-5.1.3.jar;"%REPO%"\xmlworker-1.1.1.jar;"%REPO%"\lavoisier-serializer-base-2.1.2-SNAPSHOT.jar;"%REPO%"\lavoisier-serializer-html-2.1.2-SNAPSHOT.jar;"%REPO%"\tagsoup-1.2.1.jar;"%REPO%"\lavoisier-serializer-json-2.1.2-SNAPSHOT.jar;"%REPO%"\jettison-1.3.3.jar;"%REPO%"\stax-api-1.0.1.jar;"%REPO%"\lavoisier-serializer-yaml-2.1.2-SNAPSHOT.jar;"%REPO%"\jvyaml-0.2.1.jar;"%REPO%"\lavoisier-serializer-ini-2.1.2-SNAPSHOT.jar;"%REPO%"\ini4j-0.5.2.jar;"%REPO%"\lavoisier-trigger-base-2.1.2-SNAPSHOT.jar;"%REPO%"\lavoisier-validator-base-2.1.2-SNAPSHOT.jar;"%REPO%"\lavoisier-authenticator-base-2.1.2-SNAPSHOT.jar;"%REPO%"\xml-apis-1.0.b2.jar;"%REPO%"\cas-client-core-3.3.1.jar;"%REPO%"\org.apache.oltu.oauth2.client-1.0.0.jar;"%REPO%"\org.apache.oltu.oauth2.common-1.0.0.jar;"%REPO%"\json-20131018.jar;"%REPO%"\opensaml-2.6.4.jar;"%REPO%"\openws-1.5.4.jar;"%REPO%"\xmltooling-1.4.4.jar;"%REPO%"\bcprov-jdk15on-1.51.jar;"%REPO%"\not-yet-commons-ssl-0.3.9.jar;"%REPO%"\commons-httpclient-3.1.jar;"%REPO%"\commons-codec-1.7.jar;"%REPO%"\commons-collections-3.2.1.jar;"%REPO%"\commons-lang-2.6.jar;"%REPO%"\velocity-1.7.jar;"%REPO%"\esapi-2.0.1.jar;"%REPO%"\joda-time-2.2.jar;"%REPO%"\xmlsec-1.5.7.jar;"%REPO%"\commons-logging-1.1.1.jar;"%REPO%"\lavoisier-view-templates-2.1.2-SNAPSHOT.jar;"%REPO%"\wrapper-3.2.3.jar;"%REPO%"\lavoisier-package-2.1.2-SNAPSHOT.jar

set ENDORSED_DIR=
if NOT "%ENDORSED_DIR%" == "" set CLASSPATH="%BASEDIR%"\%ENDORSED_DIR%\*;%CLASSPATH%

if NOT "%CLASSPATH_PREFIX%" == "" set CLASSPATH=%CLASSPATH_PREFIX%;%CLASSPATH%

@REM Reaching here means variables are defined and arguments have been captured
:endInit

%JAVACMD% %JAVA_OPTS% -Dlavoisier.configuration=lavoisier-config.xml -classpath %CLASSPATH% -Dapp.name="lavoisier-stop-console" -Dapp.repo="%REPO%" -Dapp.home="%BASEDIR%" -Dbasedir="%BASEDIR%" fr.in2p3.lavoisier.command.JMXOperation fr.in2p3.lavoisier.engine.jmx:type=daemon stop %CMD_LINE_ARGS%
if %ERRORLEVEL% NEQ 0 goto error
goto end

:error
if "%OS%"=="Windows_NT" @endlocal
set ERROR_CODE=%ERRORLEVEL%

:end
@REM set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" goto endNT

@REM For old DOS remove the set variables from ENV - we assume they were not set
@REM before we started - at least we don't leave any baggage around
set CMD_LINE_ARGS=
goto postExec

:endNT
@REM If error code is set to 1 then the endlocal was done already in :error.
if %ERROR_CODE% EQU 0 @endlocal


:postExec

if "%FORCE_EXIT_ON_ERROR%" == "on" (
  if %ERROR_CODE% NEQ 0 exit %ERROR_CODE%
)

exit /B %ERROR_CODE%
