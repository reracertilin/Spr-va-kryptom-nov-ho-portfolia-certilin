@REM ----------------------------------------------------------------------------
@REM Licensed to the Apache Software Foundation (ASF)
@REM Apache Maven Wrapper startup batch script, version 3.3.2
@REM ----------------------------------------------------------------------------

@IF "%__MVNW_ARG0_NAME__%"=="" (SET "BASE_DIR=%~dp0") ELSE SET "BASE_DIR=%__MVNW_ARG0_NAME__%"

@SET WRAPPER_JAR=%BASE_DIR%.mvn\wrapper\maven-wrapper.jar
@SET WRAPPER_PROPERTIES=%BASE_DIR%.mvn\wrapper\maven-wrapper.properties

@IF NOT EXIST "%WRAPPER_JAR%" (
  FOR /F "usebackq tokens=1,2 delims==" %%A IN ("%WRAPPER_PROPERTIES%") DO (
    IF "%%A"=="wrapperUrl" SET WRAPPER_URL=%%B
  )
  echo Downloading %WRAPPER_URL%
  powershell -Command "&{Invoke-WebRequest -Uri '%WRAPPER_URL%' -OutFile '%WRAPPER_JAR%'}"
)

FOR /F "usebackq tokens=1,2 delims==" %%A IN ("%WRAPPER_PROPERTIES%") DO (
  IF "%%A"=="distributionUrl" SET DISTRIBUTION_URL=%%B
)

@SET JAVA_CMD=java.exe
@IF NOT "%JAVA_HOME%"=="" SET JAVA_CMD=%JAVA_HOME%\bin\java.exe

"%JAVA_CMD%" -classpath "%WRAPPER_JAR%" ^
  "-Dmaven.multiModuleProjectDirectory=%BASE_DIR%" ^
  %MAVEN_OPTS% ^
  org.apache.maven.wrapper.MavenWrapperMain %*
