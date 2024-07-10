defmodule RealDealApiWeb.Auth.Guardian do
  use Guardian, otp_app: :real_deal_api
  alias RealDealApi.Accounts.Account
  alias RealDealApi.Accounts

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_resource, _claims), do: {:error, :no_id_provided}

  def resource_from_claims(%{"sub" => id} = _claims) do
    case Accounts.get_account!(id) do
      nil -> {:error, :not_found}
      resource -> {:ok, resource}
    end
  end

  def resource_from_claims(_claims), do: {:error, :no_id_provided}

  def authenticate(email, password) do
    with %Account{hash_password: hash_password} = account <- Accounts.get_account_by_email(email),
         true <- validate_password(password, hash_password) do
      create_token(account)
    else
      _ -> {:error, :unauthorized}
    end
  end

  defp validate_password(password, hash_password), do: Bcrypt.verify_pass(password, hash_password)

  defp create_token(account) do
    {:ok, token, _claims} = encode_and_sign(account)
    {:ok, account, token}
  end
end
