class DeepLink < RestClientCall

  ENDPOINT = "https://api.branch.io/v1/url"
  private_constant :ENDPOINT

  def create_deep_link(params)
    response = post(ENDPOINT, params)
    return response
  end

end