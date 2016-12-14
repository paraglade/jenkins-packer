stage('validate') {
  node {
    check_deps 'aws'
    checkout scm
    packer 'version'
    packer 'validate -var-file=us-west-1.json packer_ami.json'
  }
}
stage('build') {
  node {
    sh 'env'
    sh 'aws'
  }
}

def packer(args) {
    sh "${tool name: 'packer', type: 'biz.neustar.jenkins.plugins.packer.PackerInstallation'}/packer ${args}"
}

def check_deps(args) {
  echo "checking ${args}"
  sh 'which ${args}'
}
