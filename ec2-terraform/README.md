# EC2 테라포밍 예제

- 테라폼이 설치된 EC2 인스턴스에 접속해 직접 테라폼 명령어를 사용해보고 테라폼이 동작하는 원리에 대해 알아봅니다.

## terraform init

- 테라폼이 클라우드의 인프라를 구축하는 데에 AWS의 내부 API를 사용하기 때문에 `terraform init` 명령어를 실행하기 전 provider에 대해 명시한 테라폼 파일을 생성해야 합니다.

- ```
  provier "aws" {
    region = "ap-northeast-2"
  }
  ```
  파일을 작성한 후 `terraform init` 명령어를 실행하면 프로바이더를 다운로드 받을 수 있습니다.

## terraform plan

- `terraform plan` 명령으로 테라폼 파일에 명시한 리소스들의 구축의 예측 결과를 확인할 수 있습니다.

## terraform apply

- `terraform apply` 명령을 최종 실행시켜야 실제로 리소스의 생성 및 추가가 이루어지고 apply 이후 state가 저장됩니다.

## terraform import

- `terraform import`를 사용해 이미 존재하는 AWS 리소스를 apply로 생성하지 않고 import 해올 수 있습니다.

- 여기서 리소스에 대한 정보를 기입한 테라폼 파일이 존재해야 하며 같은 정보를 가진 테라폼 파일이 있는 상태에서 apply를 시도할 경우 이미 존재하기 때문에 생성되지 않습니다.

- S3 버켓을 import 하는 경우라면 `terraform import aws_s3_bucket.[테라폼에서 지정한 리소스 명] [AWS에 존재하는 버켓 이름]` 과 같이 작성해서 이미 존재하는 리소스를 불러올 수 있습니다.
