stage('build') {
  node {
    checkout scm
    sh 'pwd'
    sh 'ls -la'
    packer 'validate'
  }
}

def packer(args) {
    sh "${tool name: 'packer', type: 'biz.neustar.jenkins.plugins.packer.PackerInstallation'}/packer ${args}"
}
