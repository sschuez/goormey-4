class InstructionPositionsController < ApplicationController
  def update
    @instruction = Instruction.find(params[:instruction_id])
    authorize @instruction.recipe

    @instruction.insert_at(params[:position].to_i)
    head :ok
  end
end