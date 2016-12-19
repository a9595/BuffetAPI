require 'fcm'
# require 'rubygems'
require 'sinatra'
require 'json'
require 'json/ext' # to use the C based extension instead of json/pure


class NotificationController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    # request.body.rewind

    body = request.body.read
    p "body= \n" + body

    push_json = JSON.parse body

    # p "push_json= \n" + push_json

    send_notification(body, push_json)

=begin

    # push_json = JSON.parse '{ "orderid": "123" }'

    # push_json = JSON.parse request.body.read
    # push_json = ActiveSupport::JSON.decode(request.body.read)

    # push_json_other_way = ActiveSupport::JSON.decode(request.body.read)
    send_notification(body)
    # p request.body.read
    p "body:   " + request.body.read
    p "\nJSON:   " + push_json
    #render json: User.all

=end

    # render('demo/index')
    # redirect_to(:controller => 'products', :action => :snacks)
  end

  def send_notification(body, parsedJson)
    p "body = " + body

    deviceTokenEmulator = "fs5O5HoGKok:APA91bGnj2dKlQ0QfFnCtRU9LvhQyTbWnnw5PFLqzR6emb7r1hTCuZiD6CnLJ7ntu9wts-hZXBSkjH8A1n6bsTHqzmeyznN9pbwO1I88co-GPKsrT5F_X6P3hguA1QcZzZTVWYddXqac"
    deviceTokenPixel = "cvF-4BFKeKg:APA91bGsoIWgn9Y4psuYsY0Jf0tJMEq9UCsHPpdOyLIFjud49J4BtHqZB02OcAS6Qc0H85aVuR-VtduZH3VFJn2Ro8eA1Whs6R4X8bQLT4yyY1IqrSDqtwzOC7vbqtixf_q8ZhLM_IdJ"
    deviceToken5X = "cuxGnFB9fVQ:APA91bEBeLrDGdn2be1dGqsZb3_WRNIEkgSd0Tyn3nhuCkFTl6Ba7EYTkzDlwBrIexNddvtoC0QmjtZrM-nyD0niIXn8BkLnpV2uvLIU9Un5uaqBW3KMS0XvbWeXO2tZof7g0xTVYDqr"
    serverKey = "AAAA-Qaz-e8:APA91bHXGHIbaxoAYzSY0fWPsDA3fvNC9x0_Xa1ent9H9jYbYX-EciOOE3RrHGwMaLg_NeZ96hdZmH_H56uSgEFtNwsVZgQpZ03X-O3o3V5PMwHtHPPq37iDmNfvddBa6HDIk9gOWmGg74gHX0wg-snMas5RvFt0LA"

    # Extract params:
    # secretCodeParam = params["secretCode"]
    # tokenParam = params["token"]
    # orderKey = params["orderKey"]

    # uidParam = params["uid"]

    fcm = FCM.new(serverKey)

    mobile_tokens = [deviceTokenPixel, deviceTokenEmulator, deviceToken5X]
    # mobile_tokens = [tokenParam]
    # options = { "data": " body ", collapse_key: "updated_score" }
    options = { :notification => {
      "title": "Your meal is waiting for you",
      "body": body

    } }
    response = fcm.send(mobile_tokens, options)
    p response
    p "Sent"
  end

end
