stage('build') {
  node {
    checkout scm
    sh 'pwd'
    sh 'ls -la'
    sh 'env'
    packer 'version'
  }
}

def packer(args) {
    sh "${tool name: 'packer', type: 'biz.neustar.jenkins.plugins.packer.PackerInstallation'}/packer ${args}"
}
