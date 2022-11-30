cd swagger-codegen/modules/swagger-codegen

mvn -Dmaven.javadoc.skip=true clean install

cd ../swagger-codegen-cli

mvn -Dmaven.javadoc.skip=true clean install

cp ../../../swagger-codegen/modules/swagger-codegen-cli/target/swagger-codegen-cli.jar ../../../custom-codegen-cli-2.jar

cd ../../../

rm -rf swagger/examples/PetStoreService

java -jar custom-codegen-cli-2.jar generate \
-i https://petstore.swagger.io/v2/swagger.json \
-l spring -DinterfaceOnly=true,java11=true \
-o swagger/examples/petstore-server \
--group-id com.jtech \
--invoker-package com.jtech.petstore \
--api-package com.jtech.petstore.api \
--model-package com.jtech.petstore.model \
--artifact-id petstore-server \
--artifact-version 1.0.0-SNAPSHOT

java -jar custom-codegen-cli-2.jar generate \
-i https://petstore.swagger.io/v2/swagger.json \
-l spring -Djava11=true \
-o swagger/examples/PetStoreService \
--server-library petstore-server \
--group-id com.jtech \
--invoker-package com.jtech.petstore \
--api-package com.jtech.petstore.api \
--model-package com.jtech.petstore.model \
--artifact-id PetStoreService \
--artifact-version 1.0

cd swagger/examples/petstore-server

mvn clean package

mvn --settings ../../../settings.xml clean deploy -Dmaven.javadoc.skip=true

cd ../PetStoreService

mvn clean package

#rm -rf swagger/examples/PetStoreService