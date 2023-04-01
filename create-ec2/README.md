# EC2 인스턴스 생성해서 SSH 키로 로컬에서 접속하기

- 우선 EC2 인스턴스를 퍼블릭 서브넷에 생성합니다. 퍼블릭 서브넷에 생성해야 하는 이유는 같은 VPC 내에서 서브넷 간의 통신이 아닌 경우 퍼블릭 서브넷이어야 통신이 가능하기 때문입니다.

- EC2 인스턴스를 생성할 때 키 페어를 생성해 SSH 키의 private key를 `.pem`파일로 저장합니다.

- 로컬에서 `ssh -i [파일명.pem] ec2-user@[퍼블릭 ip] -p [포트 번호]`로 생성한 EC2 인스턴스에 접속합니다.

- 여기서 주의할 점은 pem 파일의 권한을 설정하지 않으면 접속이 되지 않습니다. 리눅스나 맥에서는 `chmod` 명령어를 사용해 간단하게 권한을 설정할 수 있습니다. 윈도우에서는 gui를 사용해 파일의 속성에서 계정 간 권한의 상속을 제거하고 현재 사용자의 권한만 준 후 접속하면 오류가 발생하지 않습니다.

## Terraform 설치

- ```
  sudo yum install -y yum-utils shadow-utils
  sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
  sudo yum -y install terraform
  ```

## AWS configure

- EC2 CLI에서 접근 권한이 있는 유저를 사용 중이라면 다른 AWS 서비스에 접근하기 위해서 사용 중인 유저의 ACCESS_KEY와 SECRET_ACCESS_KEY를 `aws configure` 명령어를 통해 입력해서 다른 서비스에 접근할 수 있습니다.

- 권한이 있다면 EC2 CLI에서 `aws s3 ls`를 통해 S3 버켓의 리스트를 확인할 수 있습니다.
