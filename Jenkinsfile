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
    packer 'build -var-file=us-west-1.json packer_ami.json | tee packer_ami.log'
  }
}

stage('tag') {
  node {

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
