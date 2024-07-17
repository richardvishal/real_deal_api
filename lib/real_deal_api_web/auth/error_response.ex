defmodule RealDealApiWeb.Auth.ErrorResponse.UnAuthorized do
  defexception message: "UnAuthorized", plug_status: 401
end

defmodule RealDealApiWeb.Auth.ErrorResponse.Forbidden do
  defexception message: "You don't have access for this resource.", plug_status: 403
end
