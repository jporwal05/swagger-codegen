cd swagger-codegen/modules/swagger-codegen

mvn -Dmaven.javadoc.skip=true clean install

cd ../swagger-codegen-cli

mvn -Dmaven.javadoc.skip=true clean install

cp ../../../swagger-codegen/modules/swagger-codegen-cli/target/swagger-codegen-cli.jar ../../../custom-codegen-cli-2.jar

cd ../../../

rm -rf swagger/examples/PetStoreService

java -jar custom-codegen-cli-2.jar generate \
-i https://petstore.swagger.io/v2/swagger.json \
-l spring -DinterfaceOnly=true -DdateLibrary=java8 \
-o swagger/examples/PetStoreService \
--group-id com.jtech \
--invoker-package com.jtech.petstore \
--api-package com.jtech.petstore.api \
--model-package com.jtech.petstore.model \
--artifact-id PetStoreService \
--artifact-version 1.0

cd swagger/examples/PetStoreService

mvn clean package

mvn --settings ../../../settings.xml clean deploy -Dmaven.javadoc.skip=true

cd ../../../

#rm -rf swagger/examples/PetStoreService