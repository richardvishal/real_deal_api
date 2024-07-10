defmodule RealDealApiWeb.Auth.ErrorResponse.UnAuthorized do
  defexception message: "UnAuthorized", plug_status: 401
end
