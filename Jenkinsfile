node {
  for (int i=0; i< 4; ++i) {  
    stage "Stage #"+i
    print "Hello, world $i!"
  }

  stage "Stage Parallel"
  def branches = [:]
  for (int i = 0; i < 4; i++) {
    def index = i
    branches["split${i}"] = {
      stage "Stage parallel- #"+index
      node('remote') {
       echo  'Starting sleep'
       sleep 10
       echo  'Finished sleep'
      }
    }
  }
  parallel branches

  sh 'ls'
}
