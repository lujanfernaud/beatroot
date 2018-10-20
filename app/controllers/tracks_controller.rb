# frozen_string_literal: true

class TracksController < ApplicationController
  def index
    @tracks = Beatroot.tracks
  end
end
