stage('validate') {
  node {
    sh 'env'
    check_deps 'aws'
    checkout scm
    packer 'version'
    packer 'validate -var-file=us-west-1.json packer_ami.json'

  }
}
stage('build') {
  node {
//    packer 'build -var-file=us-west-1.json packer_ami.json | tee packer_ami.log'
  }
}

stage('tag') {
  node {
    sh (
      script: "echo ami_id id: ${ami_id()}",
      returnStdout: true
    )
  }
}

stage('test') {
  node {

  }
}

def packer(args) {
    sh "${tool name: 'packer', type: 'biz.neustar.jenkins.plugins.packer.PackerInstallation'}/packer ${args}"
}

def check_deps(args) {
  echo "checking ${args}"
  sh "which ${args}"
}

def ami_id(){
  sh (
    script: "awk '/AMI: ami-/ { print \$4 }' packer_ami.log",
    returnStdout: true
  ).trim()
}

def distro() {
  sh (
    script: "awk '/@LSB_DISTRIBUTION/ { print \$4 }' packer_ami.log",
    returnStdout: true
  ).trim()
}

def release() {
  sh (
    script: "awk '/@LSB_RELEASE/ { print \$4 }' packer_ami.log",
    returnStdout: true
  ).trim()
}

def codename() {
  sh (
    script: "awk '/@LSB_CODENAME/ { print \$4 }' packer_ami.log",
    returnStdout: true
  ).trim()
}

def aws_tag(args) {
  sh "aws ec2 create-tags --resources ${args}"
}
