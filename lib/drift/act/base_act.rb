require_relative '../metadata/act_metadata'
require 'graphviz'
require_relative '../../../lib/drift/helper/drift_helper'

module Drift

  class BaseAct
    include Drift::DriftHelper

    class << self

      attr_accessor :start, :act_metadata

      def execute(context)
        @start.execute context
      end

      #args
      # actor_id
      # context
      def execute_actor(actor_id, context)
        raise DriftException, "No registered actor found" if @act_metadata.nil?
        @act_metadata.actor(actor_id).execute(context)  unless @act_metadata.actor(actor_id).nil?
      end

      #args
      # actor_id
      def get_actor(actor_id)
        @act_metadata.actor(actor_id)
      end

      #args
      # actor instance list
      def register_actors(*actors)
        @act_metadata = ActMetadata.new if @act_metadata.nil?
        actors.each do |actor|
          actor.act_name = self.name
          @act_metadata.register_actor actor
        end
      end

      def generate_act_diagram(path_to_store)
        graph = GraphViz.new(self.name.to_sym)
        start = graph.add_nodes(@start.identity, :shape => "ellipse")
        add_next_nodes_to_diagram(graph, @start, start, [@start.id], {@start.id => start})
        graph.output(:png => "#{path_to_store}/#{self.name}.png")
      end

      private
      def add_next_nodes_to_diagram(graph, actor_instance, actor_node, id_list, node_list_hash)
        next_actor_map = actor_instance.metadata.next_actor_map
        next_actor_map.each do |key, next_actor_id|
          next_node = nil
          next_actor = @act_metadata.actor(next_actor_id)

          # null actor check
          next if next_actor.nil?

          if id_list.include?(next_actor.id)
            next_node = node_list_hash[next_actor.id]
          else
            case next_actor
              when SingleActor
                next_node = graph.add_nodes(next_actor.identity, :shape => "box")
              when SwitchActor
                next_node = graph.add_nodes(next_actor.identity, :shape => "diamond")
            end

            node_list_hash.merge!({next_actor.id => next_node})
          end

          if key.nil?
            graph.add_edges(actor_node, next_node)
          else
            graph.add_edges(actor_node, next_node, :label => key.to_s)
          end

          # circular reference check
          unless id_list.include?(next_actor.id)
            id_list << next_actor.id
            add_next_nodes_to_diagram(graph, next_actor, next_node, id_list, node_list_hash)
          end

        end
      end

    end

  end

end
