require "test_helper"

module MissionControl::Servers
  class IngressesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @project = mission_control_servers_projects(:one)
    end

    test "should create ingress" do
      assert_difference('Service.count') do
        post project_ingress_url(@project.token), params: {
          service: {
            hostname: 'example.com',
            cpu: '2',
            mem_used: '1024',
            mem_free: '2048',
            disk_free: '100GB'
          }
        }
      end
      assert_response :ok
    end

    test "should not create ingress for non-existing project" do
      assert_no_difference('Service.count') do
        post project_ingress_url('non-existing'), params: {
          service: {
            hostname: 'example.com',
            cpu: '2',
            mem_used: '1024',
            mem_free: '2048',
            disk_free: '100GB'
          }
        }
      end
      assert_response :not_found
    end
  end
end
