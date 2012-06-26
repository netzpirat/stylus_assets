describe 'StylusAssets', ->
  beforeEach ->
    StylusAssets.prefixVariables = false
    
  describe '#render', ->
    describe 'a less stylesheet', ->
      beforeEach ->
        @result = StylusAssets.render 'template', '''
          #header {
            #logo {
              margin: 10px;
            }
          }
        '''

      it 'renders the less style sheet to css', ->
        expect(@result).toEqual '''
          #header #logo {
            margin: 10px;
          }

        '''

    describe 'when passing variables', ->
      describe 'for variables that does not exist', ->
        beforeEach ->
          @result = StylusAssets.render 'template', '''
            #logo {
              border-radius: radius;
            }
          ''', { radius: '10px' }

        it 'adds the variable', ->
          expect(@result).toEqual '''
            #logo {
              border-radius: 10px;
            }

          '''

      describe 'for variables that does exist', ->
        beforeEach ->
          @result = StylusAssets.render 'template', '''
            box-margin = 10px
            box-padding = 10px

            .box {
              margin: box-margin;
              padding: box-padding;
            }
          ''', { 'box-margin': '20px' }

        it 'replaces the existing variable', ->
          expect(@result).toEqual '''
            .box {
              margin: 20px;
              padding: 10px;
            }

          '''

      describe 'for an Array value', ->
        beforeEach ->
          @result = StylusAssets.render 'template', '''
            for c in cols
              .{c}
                border: 0
          ''', { 'cols': [1, 2, 3] }

        it 'replaces the existing variable', ->
          expect(@result).toEqual '''
            .1 {
              border: 0;
            }
            .2 {
              border: 0;
            }
            .3 {
              border: 0;
            }

          '''
        
      describe 'when prefixing the variables', ->
        beforeEach ->
          StylusAssets.prefixVariables = true
          
        describe 'for variables that does not exist', ->
          beforeEach ->
            @result = StylusAssets.render 'template', '''
              #logo {
                border-radius: $radius;
              }
            ''', { radius: '10px' }
  
          it 'adds the variable', ->
            expect(@result).toEqual '''
              #logo {
                border-radius: 10px;
              }

            '''

        describe 'for variables that does exist', ->
          beforeEach ->
            @result = StylusAssets.render 'template', '''
              $box-margin = 10px
              $box-padding = 10px

              .box {
                margin: $box-margin;
                padding: $box-padding;
              }
            ''', { 'box-margin': '20px' }
  
          it 'replaces the existing variable', ->
            expect(@result).toEqual '''
              .box {
                margin: 20px;
                padding: 10px;
              }

            '''

        describe 'for an Array value', ->
          beforeEach ->
            @result = StylusAssets.render 'template', '''
              for c in $cols
                .{c}
                  border: 0
            ''', { 'cols': [1, 2, 3] }
  
          it 'replaces the existing variable', ->
            expect(@result).toEqual '''
              .1 {
                border: 0;
              }
              .2 {
                border: 0;
              }
              .3 {
                border: 0;
              }

            '''

    describe 'when passing an HTML element', ->
      describe 'for a non existing style', ->
        beforeEach ->
          StylusAssets.render 'template/head', '''
            #logo {
              border-radius: 5px;
            }
          ''', { }, document

        afterEach -> $('#stylus-asset-template-head').remove()

        it 'creates a script tag', ->
          expect($(document)).toContain 'style#stylus-asset-template-head'

        it 'adds the css to the tag', ->
          expect($('#stylus-asset-template-head').text()).toEqual '''
            #logo {
              border-radius: 5px;
            }

          '''

      describe 'for an existing style', ->
        beforeEach ->
          $(document).find('head').append '<style id="stylus-asset-template-head">div { padding: 1px; }</style>'
          StylusAssets.render 'template/head', '''
            div {
              padding: 5px;
            }
          ''', { }, document

        afterEach -> $('#stylus-asset-template-head').remove()

        it 'replaces the css in the tag', ->
          expect($('#stylus-asset-template-head').text()).toEqual '''
            div {
              padding: 5px;
            }
            
          '''
