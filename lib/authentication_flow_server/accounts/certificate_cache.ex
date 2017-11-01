defmodule AuthenticationFlowServer.Accounts.CertificateCache do
  def fetch(date, default_value_function) do
    case get(date) do
      {:not_found} -> not_found(date, default_value_function)
      {:found, certificates} -> {:ok, certificates}
    end
  end

  defp get(date) do
    data = FastGlobal.get(:data)

    case data != nil && data.date == date do
      true -> {:found, data.certificates}
      false -> {:not_found}
    end
  end

  defp set(date, value) do
    data = %{
      date: date,
      certificates: value
    }

    {FastGlobal.put(:data, data), value}
  end

  defp not_found(date, default_value_function) do
    case default_value_function.() do
      {:error, message} ->
        {:error, message}
      {:ok, certificates } ->
        set(date, certificates)
    end
  end
end
