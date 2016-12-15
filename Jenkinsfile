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
  //  packer 'build -color=false -var-file=us-west-1.json packer_ami.json | tee packer_ami.log'
  }
}

stage('tag') {
  node {
    sh (
      script: "echo ami_id id: ${ami_id()}",
      returnStdout: true
    )
    aws_tag (
      resources: ami_id(),
      tags: " \
        Key=state,Value=initialized \
        Key=distro,Value=${distro()} \
        Key=release,Value=${release()} \
        Key=release_name,Value=${codename()} \
        Key=build_server,Value=${env.HOSTNAME} \
        Key=build_node,Value=${env.NODE_NAME} \
        Key=build_id,Value=${env.BUILD_ID} \
        Key=build_id,Value=${env.BUILD_ID} \
      ",
      region: 'us-west-1'
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
    script: "awk '/AMI: ami-/ { print \$3 }' packer_ami.log",
    returnStdout: true
  ).trim()
}

def distro() {
  sh (
    script: "awk '/@LSB_DISTRIBUTION/ { print \$3 }' packer_ami.log",
    returnStdout: true
  ).trim()
}

def release() {
  sh (
    script: "awk '/@LSB_RELEASE/ { print \$3 }' packer_ami.log",
    returnStdout: true
  ).trim()
}

def codename() {
  sh (
    script: "awk '/@LSB_CODENAME/ { print \$3 }' packer_ami.log",
    returnStdout: true
  ).trim()
}

def aws_tag(Map args) {
  sh (
    script: "aws ec2 create-tags --region ${args.region} --resources ${args.resources} --tags ${args.tags}",
    returnStdout: true
  )
}
