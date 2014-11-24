Recaptcha.configure do |config|

  if Rails.env.production? 
    #Temporary: cama.summers.com.tw
    # config.public_key  = '6Lc_EPoSAAAAAKefE6nMepworHqRe0wtWdJtf7d8'
    # config.private_key = '6Lc_EPoSAAAAAKoNHBzl3XCWhtK2ZT3d_tzNn1El'
    
    # li664-20.members.linode.com
    config.public_key  = '6LfjHfwSAAAAAE0fEIAVzc61UExdBtj_W2DfsAjX'
    config.private_key = '6LfjHfwSAAAAAN3tJ_hpCc8L8yMwQaxB7ZnrP3gi'

    #config.proxy = 'http://myproxy.com.au:8080'
  else 
    #Temporary: www.camacafe.com, because localhost is ok
    config.public_key  = '6LcEsfgSAAAAAH0VkjdEFPXXc38FSMQ8zDu9YZ7b'
    config.private_key = '6LcEsfgSAAAAALRIl7Zws6fm88A7dMfgbSLxQuve'
    #config.proxy = 'http://myproxy.com.au:8080'
  end
end