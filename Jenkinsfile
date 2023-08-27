// pipeline {
//     agent any
//     stages{
//         stage('vcs') {
//             steps {
//                 git url: 'https://github.com/divyakothuru311/terraform-jenkins.git',
//                        branch: 'main'
//             }
//         }
//         stage('create vm via terraform') {
//             steps {
//                 sh 'terraform init'
//                 sh 'terraform validate'
//                 sh 'terraform apply -var-file="dev.tfvars" -auto-approve'
//             }
//         }
//     }
// }