defmodule AuthenticationFlowServer.Mail.SendgridMailer do
  @moduledoc """
  Functions for sending email through the Sendgrid API
  """

  alias AuthenticationFlowServer.Mail.{Email, PasswordResetEmail}

  @send_path "https://api.sendgrid.com/v3/mail/send"
  @api_key Application.get_env(:authentication_flow_server, :sendgrid_api_key)

  def deliver_later(:password_reset_created, recipient_email, token) do
    params =
      PasswordResetEmail.created_email(recipient_email, token)
      |> send_params

    spawn fn ->
      HTTPoison.post!(@send_path, params, headers())
    end
  end

  defp send_params(%Email{to: to_email, from: from_email, subject: subject, body: body}) do
    %{"personalizations" => [
        %{"to" => [%{"email" => to_email}], "subject" => subject}
      ],
      "from" => %{
        "email" => from_email
      },
      "content" => [
        %{"type" => "text/plain", "value" => body}
      ]}
    |> Poison.encode!
  end

  defp headers do
    %{
      "Authorization" => "Bearer #{@api_key}",
      "Content-Type" => "application/json"
    }
  end
end
