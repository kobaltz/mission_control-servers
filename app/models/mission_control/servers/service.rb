module MissionControl::Servers
  class Service < ApplicationRecord
    belongs_to :project
    after_create :trim_old_records
    before_create :set_hostname

    scope :ordered, -> { order(created_at: :desc) }

    class << self
      def combo_history(services, start_time: 1.hour.ago, end_time: Time.now.utc)
        timestamps = (start_time.to_i..end_time.to_i).step(60).map { |t| Time.at(t).utc.change(sec: 0).to_i }
        grouped_services = services.group_by { |service| service.created_at.utc.change(sec: 0).to_i }

        cpu_usages = []
        memory_usages = []
        created_at_times = []

        timestamps.each do |timestamp|
          relevant_services = grouped_services[timestamp] || []
          max_cpu_service = relevant_services.max_by(&:cpu)
          max_memory_service = relevant_services.max_by do |service|
            return 0 if service.mem_used.to_f + service.mem_free.to_f == 0.0
            service.mem_used.to_f / (service.mem_used.to_f + service.mem_free.to_f)
          end
          cpu_usages << (max_cpu_service&.cpu || 0).to_f
          if max_memory_service
            total_memory = max_memory_service.mem_used.to_f + max_memory_service.mem_free.to_f
            percentage_memory_used = (max_memory_service.mem_used.to_f / total_memory) * 100
            memory_usages << percentage_memory_used.to_i
          else
            memory_usages << 0.0
          end
          created_at_times << Time.at(timestamp).utc.strftime('%H:%M%p')
        end

        data = [
          {
            label: 'CPU Usage',
            data: cpu_usages,
            fill: true,
            borderColor: "rgb(54, 162, 235)",
            tension: 0.25
          },
          {
            label: 'Memory Usage',
            data: memory_usages,
            fill: true,
            borderColor: "rgb(235, 127, 54)",
            tension: 0.25
          }
        ]
        { created_at_times: created_at_times, data: data }
      end


      def cpu_usage_history(services, start_time: 1.hour.ago, end_time: Time.now.utc)
        timestamps = (start_time.to_i..end_time.to_i).step(60).map { |t| Time.at(t).utc.change(sec: 0).to_i }
        grouped_services = services.group_by { |service| service.created_at.utc.change(sec: 0).to_i }

        cpu_usages = []
        created_at_times = []

        timestamps.each do |timestamp|
          relevant_services = grouped_services[timestamp] || []
          max_cpu_service = relevant_services.max_by(&:cpu)
          cpu_usages << (max_cpu_service&.cpu || 0).to_f
          created_at_times << Time.at(timestamp).utc.strftime('%H:%M%p')
        end

        { cpu_usages: cpu_usages, created_at_times: created_at_times }
      end


      def memory_usage_history(services, start_time: 1.hour.ago, end_time: Time.now.utc)
        timestamps = (start_time.to_i..end_time.to_i).step(60).map { |t| Time.at(t).utc.change(sec: 0).to_i }
        grouped_services = services.group_by { |service| service.created_at.utc.change(sec: 0).to_i }

        memory_usages = []
        created_at_times = []

        timestamps.each do |timestamp|
          relevant_services = grouped_services[timestamp] || []
          max_memory_service = relevant_services.max_by(&:mem_used)
          memory_usages << (max_memory_service&.mem_used || 0).to_f
          created_at_times << Time.at(timestamp).utc.strftime('%H:%M%p')
        end

        { memory_usages: memory_usages, created_at_times: created_at_times }
      end
    end

    def mem_percent
      return 0 if mem_used.to_f + mem_free.to_f == 0.0
      (mem_used.to_f / (mem_used.to_f + mem_free.to_f) * 100).to_i
    end

    private

    def trim_old_records
      project.services.where(hostname: hostname).where(created_at: ..1.week.ago).delete_all
    end

    def set_hostname
      self.hostname ||= "unnamed server"
    end
  end
end
