require 'rails_helper'
require 'monkey_patch'

describe MoviesController do 
    fixtures :movies
    describe 'Looking for movies with same director' do
        it 'should not find movies - sad path' do 
            expect(Movie).to receive(:find).with("1").and_return(movies(:mymovie_4))
            get :same_director, id: 1
            response.response_code.should == 302
            expect(response).to redirect_to movies_path
        end
        it 'should find movies - happy path' do 
            expect(Movie).to receive(:same_director_movies).with(movies(:mymovie_1).director).and_return([movies(:mymovie_1), movies(:mymovie_2)])
            expect(Movie).to receive(:find).with(movies(:mymovie_1).id.to_s).and_return(movies(:mymovie_1))
            get :same_director, id: movies(:mymovie_1).id
            response.response_code.should == 200
        end
    end
    
    describe 'Testing create method' do
        it 'should create movie' do
            expect(Movie).to receive(:create!).with({'title':'mymovie_2', 'director':'test'}).and_return(movies(:mymovie_2))
            post :create, {:movie => {'title':'mymovie_2', 'director':'test'}}
            expect(flash[:notice]).to match (/was successfully created./)
        end
    end
    
    describe 'Testing update method' do
        it 'should update movie' do
            expect(Movie).to receive(:find).with(movies(:mymovie_2).id.to_s).and_return(movies(:mymovie_2))
            expect(movies(:mymovie_2)).to receive(:update_attributes!).with({'title':'mymovie_2', 'director':'test'}).and_return(movies(:mymovie_2))
            put :update, {:id => movies(:mymovie_2).id, :movie => {'title':'mymovie_2', 'director':'test'}}
            expect(flash[:notice]).to match (/was successfully updated./)
        end
    end
    
    describe 'Testing edit method' do
        it 'should edit movie' do
            expect(Movie).to receive(:find).with(movies(:mymovie_2).id.to_s).and_return(movies(:mymovie_2))
            get :edit, id: movies(:mymovie_2).id
            response.response_code.should == 200
        end
    end
    
    describe 'Testing show method' do
        it 'should show movie' do
            expect(Movie).to receive(:find).with(movies(:mymovie_2).id.to_s).and_return(movies(:mymovie_2))
            get :show, id: movies(:mymovie_2).id
            response.response_code.should == 200
            expect(response).to render_template("movies/show")
        end
    end
    
    describe 'Testing destroy method' do
        it 'should destroy movie' do
            expect(Movie).to receive(:find).with(movies(:mymovie_2).id.to_s).and_return(movies(:mymovie_2))
            expect(movies(:mymovie_2)).to receive(:destroy)
            delete :destroy, id: movies(:mymovie_2).id
            expect(flash[:notice]).to match (/Movie 'mymovie_2' deleted/)
            response.response_code.should == 302
        end
    end
    
    describe 'Testing new method' do
        it 'should open page for new movie' do
            get :new
            response.response_code.should == 200
        end
    end
    
    describe 'Testing index method' do
        it 'should get movies' do
            expect(Movie).to receive(:all).and_return([movies(:mymovie_1), movies(:mymovie_2)])
            get :index
            response.response_code.should == 200
        end
    end
    
end