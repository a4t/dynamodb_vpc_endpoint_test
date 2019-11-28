# dynamodb_vpc_endpoint_test

## Setting

```
$ git clone git@github.com:a4t/dynamodb_vpc_endpoint_test.git
$ cd dynamodb_vpc_endpoint_test
```

## development

```
$ docker-compose up -d dynamodb-local
$ docker-compose run scripts python init.py
$ docker-compose run scripts python main.py
```

## Edit config

```
$ $EDITOR config/aws.env
```

## Deploy

```
$ docker-compose run terraform init
$ docker-compose run terraform plan
$ docker-compose run terraform apply -auto-approve
```
