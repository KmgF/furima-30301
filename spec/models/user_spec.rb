require 'rails_helper'
describe User do
  before do
    @user = FactoryBot.build(:user)
end

describe'ユーザー新規登録' do
  context '新規登録がうまくいく時' do
    it"nickname,email,password,password_confirmation,first_name,family_name,first_name_kana,family_name_kana,birthday全て存在すれば登録できる" do
      expect(@user).to be_valid
    end
    it "emailに@が含まれていると登録できる" do
      @user.email = "test@test"
      expect(@user).to be_valid
    end
    it "passwordは6文字以上で登録できる" do
      @user.password = Faker::Internet.password(min_length:6,max_length:6)
      @user.password_confirmation = @user.password
      expect(@user).to be_valid
    end
    it "passwordは英数字混合で登録できる" do
      @user.password = "TEST123test"
      @user.password_confirmation = "TEST123test"
      expect(@user).to be_valid
    end

    it 'first_nameは漢字、ひらがな、全角カタカナで登録できる'do
     @user.first_name='あイ宇えお'
     expect(@user).to be_valid
    end

    it'family_nameは漢字、ひらがな、全角カタカナで登録できる' do
      @user.family_name = '火きクけこ'
      expect(@user).to be_valid
    end

    it 'first_name_kanaは全角カタカナで登録できる' do
      @user.first_name_kana = 'アイウエオ'
      expect(@user).to be_valid
    end

    it 'family_name_kanaは全角カタカナで登録できる' do
      @user.family_name_kana = 'カキクケコ'
      expect(@user).to be_valid
    end

  end

  context'登録できない時' do
    it'nicknameが空だと登録できない' do
      @user.nickname = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank") 
    end
    it 'emailが空だと登録できない' do
      @user.email=""
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it'paswordは空だと登録できない'do
    @user.password=""
    @user.valid?
    expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordは数字だけだと登録できない' do
      @user.password = "123456"
      @user.password_confirmation = "123456"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
    end

    it'passwordは英字だけだと登録できない'do
    @user.password = "abcdefg"
    @user.password_confirmation = "abcdefg"
    @user.valid?
    expect(@user.errors.full_messages).to include("Password is invalid")
    end

    it'passwordとpassword_confirmationは一致していないと登録できない'do
    @user.password = "123abc"
    @user.password_confirmation= "234bcd"
    @user.valid?
    expect(@user.errors.messages).to include(:password_confirmation => ["doesn't match Password"])
    end

    it 'passwordが存在しても、password_confitmationは空だと登録できない' do
    @user.password = Faker::Internet.password(min_length:6)
    @user.password_confirmation = ""
    @user.valid?
    expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'first_nameは空だと登録できない' do
      @user.first_name=""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank", "First name 漢字、ひらがな、全角カタカナのみ使用できます")
    end

    it 'first_nameは半角英字では登録できない' do
      @user.first_name="Nick"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name 漢字、ひらがな、全角カタカナのみ使用できます")
    end

    it 'first_nameは半角カタカナでは登録できない' do
      @user.first_name="ﾆｯｸ"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name 漢字、ひらがな、全角カタカナのみ使用できます")
    end

    it'family_nameは空だと登録できない' do
      @user.family_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name 漢字、ひらがな、全角カタカナのみ使用できます")
    end

    it 'family_nameは半角英字だと登録できない' do
      @user.family_name="Wild"
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name 漢字、ひらがな、全角カタカナのみ使用できます")
    end

    it 'first_name_kanaは空だと登録できない' do
      @user.first_name_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank","First name kana 全角カタカナのみ使用できます")
    end

    it 'first_name_kanaは半角カタカナだと登録できない' do
      @user.first_name_kana ="ﾆｯｸ"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana 全角カタカナのみ使用できます")
    end

    it'first_name_kanaは漢字だと登録できない'do
      @user.first_name_kana = "肉"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana 全角カタカナのみ使用できます")
    end

    it 'first_name_kanaはひらがなだと登録できない'do
    @user.first_name_kana = "にっく"
    @user.valid?
    expect(@user.errors.full_messages).to include("First name kana 全角カタカナのみ使用できます")
    end

    it 'first_name_kanaは半角英字だと登録できない'do
    @user.first_name_kana = "Nick"
    @user.valid?
    expect(@user.errors.full_messages).to include("First name kana 全角カタカナのみ使用できます")
    end

    it 'family_name_kanaは空だと登録できない' do
      @user.family_name_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana can't be blank","Family name kana 全角カタカナのみ使用できます")
    end

    it 'family_name_kanaは半角カタカナだと登録できない' do
      @user.family_name_kana = "ﾆｯｸ"
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana 全角カタカナのみ使用できます")
    end

    it 'family_name_kanaは半角英字だと登録できない' do
      @user.family_name_kana = "Wild"
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name kana 全角カタカナのみ使用できます")
    end

    it'family_name_kanaは漢字だと登録できない'do
    @user.family_name_kana = "野生"
    @user.valid?
    expect(@user.errors.full_messages).to include("Family name kana 全角カタカナのみ使用できます")
    end

    it 'family_name_kanaはひらがなだと登録できない'do
    @user.family_name_kana = "わいるど"
    @user.valid?
    expect(@user.errors.full_messages).to include("Family name kana 全角カタカナのみ使用できます")
    end

    it 'birthdayは空だと登録できない'do
      @user.birthday=""
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  
  end


end
  
end