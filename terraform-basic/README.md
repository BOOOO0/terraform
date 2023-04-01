# Infrastructure as Code

- 테라폼은 코드로써의 인프라로 인프라 구성요소들을 코드를 통해 구축하는 것입니다.

- IaC는 인프라를 코드로 다루기 때문에 재사용성이 높으며 유지 보수가 용이합니다.

## Terraform

- 테라폼은 가장 많이 쓰이는 IaC 툴로 문법이 쉬워 다루기 쉽고 참고할 수 있는 예제가 많은 장점이 있습니다.

- 테라폼 스크립트는 `.tf` 형식의 파일 형식을 가집니다.

## 테라폼 구성요소

- `provider` - 테라폼으로 생성할 인프라의 종류를 의미합니다. 클라우드에 인프라를 구축하는 경우 어떤 클라우드 컴퓨팅 서비스를 이용할 것인지를 명시하며 AWS, Azure와 같은 클라우드 인프라를 예로 들 수 있습니다. provider를 통해 리소스들을 다루기 위한 SDK와 같은 파일들을 다운로드 받게 됩니다.

  ```
  provider "aws" {
    region = "ap-northeast-2"
    version = "~> 3.0"
  }
  ```

- `resource` - 테라폼으로 실제로 생성할 인프라 자원을 의미합니다. AWS에 인프라를 구축하는 경우 vpc나 EC2 인스턴스를 명시하는 부분이며

  ```
  resource "aws_vpc" "실제 리소스의 이름" {
    cidr_block = "10.0.0.0/16"
  }
  ```

  와 같이 작성할 수 있습니다.

- `state` - 테라폼을 통해 생성한 자원의 상태를 의미합니다. `terraform.tfstate`라는 파일명을 가집니다. 테라폼으로 작성한 코드를 실제로 실행하면 생성되는 파일입니다. 생성한 리소스의 결과값이며 현재 인프라의 상태와는 상이할 수 있으며 terraformstate와 현재 인프라의 상태를 동일하게 유지해야 합니다. state 파일은 원격 저장소인 backend에 저장됩니다.

- `output` - 테라폼으로 만든 자원을 변수 형태로 state에 저장하는 것을 의미합니다.

  ```
  output "vpc_id" {
    value = aws_vpc.default.id
  }
  ```

  와 같이 작성해서 원하는 값을 state에 전달할 수 있습니다.

- `module` - 공통적으로 활용할 수 있는 코드를 모듈화하는 것을 의미합니다.

  ```
  module "vpc" {
    source = "../_modules/vpc"

    cidr_block = "10.0.0.0/16"
  }
  ```

  와 같이 사용하며 경로를 명시해 해당 경로의 하위 리소스 파일들을 참조합니다.

- `remote` - 다른 경로의 state를 참조하는 것을 의미하며 `output` 변수를 불러올 때 주로 사용합니다. remote를 사용해 state에 저장된 output들을 불러와 변수로 사용할 수 있습니다.

  ```
  data "terraform_remote_state" "vpc" {
    backend = "remote"

    config = {
      bucket = "terraform-s3-bucket"
      region = "ap-northeast-2"
      key = "terraform/vpc/terraform.tfstate"
    }
  }
  ```

  와 같이 사용하면 key에 명시된 내용을 state에서 terraform_remote_state.vpc라는 값으로 불러와 사용할 수 있습니다.

## 테라폼 명령어

- `init` - 테라폼 명령어 사용을 위해 필요한 설정을 진행합니다.

- `plan` - 테라폼으로 작성한 코드가 실제로 어떻게 동작할 지에 대한 예측을 보여줍니다.

- `apply` - 작성한 테라폼 코드로 인프라를 실제로 생성하는 명령어입니다.

- `import` - 이미 만들어진 인프라 자원을 테라폼 state 파일로 불러오는 명령어입니다.

- `state` - state 파일을 다룰 때 사용하는 명령어입니다.

- `destroy` - 생성된 모든 자원들을 state 파일 기준으로 모두 삭제하는 명령어입니다.

## 테라폼 명령어 프로세스

- 최초에 `terraform init`으로 provider, state, module의 설정을 진행한 후 `terraform plan`을 통해 작성한 테라폼 코드가 문제없이 동작하는지 확인합니다.

- 그 후 최종적으로 문제가 없을 경우 `terraform apply`를 사용해 코드로 구축한 인프라를 적용시킵니다.
