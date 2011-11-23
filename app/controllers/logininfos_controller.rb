# -*- coding: utf-8 -*-
class LogininfosController < ApplicationController
  before_filter :authenticate_user!  
  # GET /logininfos
  # GET /logininfos.json
  def index
    @logininfos = current_user.logininfos.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @logininfos }
    end
  end

  # GET /logininfos/1
  # GET /logininfos/1.json
  def show
    @logininfo = Logininfo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @logininfo }
    end
  end

  # GET /logininfos/new
  # GET /logininfos/new.json
  def new
    @logininfo = Logininfo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @logininfo }
    end
  end

  # GET /logininfos/1/edit
  def edit
    @logininfo = Logininfo.find(params[:id])
  end

  # POST /logininfos
  # POST /logininfos.json
  def create
    @logininfo = Logininfo.new(params[:logininfo])
    @logininfo.user = current_user

    
    @twinsu_form = <<FORM
<form name="login" method="post" action="https://twins.tsukuba.ac.jp/tbu/campus/" target="_blank" >
<INPUT type="hidden" name="view" value="view.initial">
<INPUT type="hidden" name="func" value="function.login">
<input type="text" name="usernm" value="#{@logininfo.account}">
<input type="password" name="passwd" value="#{@logininfo.password}">
<input type="submit" value="Login">
</form>
FORM
    
    @twinsg_form = <<FORM
<form name="login" method="post" action="https://twins.tsukuba.ac.jp/tbu-g/campus/" target="_blank">
<INPUT type="hidden" name="view" value="view.initial">
<INPUT type="hidden" name="func" value="function.login">
<input type="text" name="usernm" value="#{@logininfo.account}">
<input type="password" name="passwd" value="#{@logininfo.password}">
<input type="submit" value="Login">
</form>
FORM

    @tsukubamail_form = <<FORM
<form name="login" method="POST" action="https://wmail.u.tsukuba.ac.jp/am_bin/amlogin/login_auth" target="_blank" >
<input type="text" name="am_authid" value="#{@logininfo.account}">
<input type="password" name="am_authpasswd" value="#{@logininfo.password}">
<input type="submit" value="Login">
</form>
FORM

    @tsukuba_coins_mail = <<FORM
<form action="https://www.coins.tsukuba.ac.jp/webmail/src/redirect.php" method="post" name="login_form" target="_blank" >
<input type="text" name="login_username" value="#{@logininfo.account}" onfocus="alreadyFocused=true;" />
<input type="password" name="secretkey" value="#{@logininfo.password}" onfocus="alreadyFocused=true;" />
<input type="hidden" name="js_autodetect_results" value="0" />
<input type="hidden" name="just_logged_in" value="1" />
<input type="submit" value="Login" />
</form>
FORM

    @twitter = <<FORM
<form action="https://twitter.com/sessions?phx=1" class="signin" method="post" target="_blank">
<input type="text" value="#{@logininfo.account}" name="session[username_or_email]" autocomplete="on" />
<input type="password" value="#{@logininfo.password}" name="session[password]" />
<input type="hidden" value="0" name="remember_me" />
<input type="submit" value="Login" />
</form>
FORM

    @moodle_form = <<FORM
<form action="https://idp.account.tsukuba.ac.jp/idp/Authn/UserPassword" method="post" target="_blank">
<input name="j_username" type="text" value="#{@logininfo.account}" />
<input name="j_password" type="password" value="#{@logininfo.password}" />
<input type="submit" value="Login" />
</form>
FORM

    @trios_form =<<FORM
<form name="LOGIN" method="POST" action="https://trios.tsukuba.ac.jp/scripts/update/kkmain.htm" target="_blank">
<input type="text" name="LOGIN_ID" value="#{@logininfo.account}" >
<input type="PASSWORD" name="PASS_WORD" value="#{@logininfo.password}" >
<input type="submit" name="OK" value="Login" >　
<input type="hidden" name="BUTTON_NO" value="1">
</form>
FORM

    @fair_form =<<FORM
<form name="loginForm" method="post" action="https://fair.tsukuba.ac.jp/ncnu/Login.do" target="_blank">
<input type="text" name="Uid" value="#{@logininfo.account}">
<input type="password" name="Pwd" value="#{@logininfo.password}">
<input type="submit" value="Login">
<input type="HIDDEN" name="RequestAction" value="ActionLogin">
</form>
FORM


    if(@logininfo.url == "https://twins.tsukuba.ac.jp/tbu-g/campus") 
      @logininfo.form = @twinsg_form
    elsif(@logininfo.url == "https://twins.tsukuba.ac.jp/tbu/campus")
      @logininfo.form = @twinsu_form
    elsif(@logininfo.url == "https://wmail.u.tsukuba.ac.jp/am_bin/amlogin/login_auth")
      @logininfo.form = @tsukubamail_form
    elsif(@logininfo.url == "https://www.coins.tsukuba.ac.jp/webmail/src/redirect.php")
      @logininfo.form = @tsukuba_coins_mail
    elsif(@logininfo.url == "https://twitter.com/sessions?phx=1")
      @logininfo.form = @twitter
    elsif(@logininfo.url == "https://idp.account.tsukuba.ac.jp/idp/Authn/UserPassword")
      @logininfo.form = @moodle_form
    elsif(@logininfo.url == "https://trios.tsukuba.ac.jp/scripts/update/kkmain.htm")
      @logininfo.form = @trios_form
    elsif(@logininfo.url == "https://fair.tsukuba.ac.jp/ncnu/Login.do")
      @logininfo.form = @fair_form
    end
    

    respond_to do |format|
      if @logininfo.save
        format.html { redirect_to @logininfo, :notice => 'Logininfo was successfully created.' }
        format.json { render :json => @logininfo, :status => :created, :location => @logininfo }
      else
        format.html { render :action => "new" }
        format.json { render :json => @logininfo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /logininfos/1
  # PUT /logininfos/1.json
  def update
    @logininfo = Logininfo.find(params[:id])

    respond_to do |format|
      if @logininfo.update_attributes(params[:logininfo])
        format.html { redirect_to @logininfo, :notice => 'Logininfo was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @logininfo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /logininfos/1
  # DELETE /logininfos/1.json
  def destroy
    @logininfo = Logininfo.find(params[:id])
    @logininfo.destroy

    respond_to do |format|
      format.html { redirect_to logininfos_url }
      format.json { head :ok }
    end
  end
end
