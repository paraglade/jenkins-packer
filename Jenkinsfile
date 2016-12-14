stage('build') {
  node {
    checkout scm
    sh 'pwd'
    sh 'ls -la'
    tool name: 'packer', type: 'biz.neustar.jenkins.plugins.packer.PackerInstallation'
  }
}
