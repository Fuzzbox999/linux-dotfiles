import dmenu_extended
import sys

file_prefs = dmenu_extended.path_prefs + '/internetSearch.json'

class extension(dmenu_extended.dmenu):

  title = 'Internet search: '
  is_submenu = True


  def create_default_providers(self):
    default = {
      'providers': [
        {
          'title': 'Google',
          'url': 'https://www.google.com/search?q={searchterm}'
        },
        {
          'title': 'Wikipedia',
          'url': 'https://en.wikipedia.org/wiki/Special:Search?search={searchterm}'
        },
        {
          'title': 'Google images',
          'url': 'https://www.google.com/images?q={searchterm}'
        },
        {
          'title': 'Github',
          'url':  'https://github.com/search?q={searchterm}'
        }
      ],
      'default': 'Google'
    }
    self.save_json(file_prefs, default)


  def load_providers(self):
    providers = self.load_json(file_prefs)
    if providers == False:
      self.create_default_providers()
      providers = self.load_json(file_prefs)

    uptodate = False
    for provider in providers['providers']:
      if provider['url'].find('{searchterm}') != -1:
        uptodate = True
        break

    if not uptodate:
      print('Search providers list is out-of-date, replacing (old list saved)')
      self.save_json(file_prefs[:-5]+'_old.json', providers)
      self.create_default_providers()
      return self.load_providers()

    return providers


  def conduct_search(self, searchTerm, providerName=False):
    default = self.providers['default']
    primary = False
    fallback = False

    for provider in self.providers['providers']:
      if provider['title'] == default:
        # fallback = provider['url'].replace("%keywords%", searchTerm)
        fallback = provider['url'].format(searchterm=searchTerm)
      elif provider['title'] == providerName:
        # primary = provider['url'].replace("%keywords%", searchTerm)
        primary = provider['url'].format(searchterm=searchTerm)

    if primary:
      self.open_url(primary)
    else:
      self.open_url(fallback)


  def run(self, inputText):

    self.providers = self.load_providers()

    if inputText != '':
      self.conduct_search(inputText)
    else:

      items = []
      for provider in self.providers['providers']:
        items.append(provider['title'])

      item_editPrefs = self.prefs['indicator_edit'] + ' Edit search providers'

      items.append(item_editPrefs)

      provider = self.menu(items, prompt='Select provider:')

      if provider == item_editPrefs:
        self.open_file(file_prefs)
      elif provider == '':
        sys.exit()
      else:
        if provider not in items:
          self.conduct_search(provider)
        else:
          search = self.menu('', prompt='Enter search')
          if search == '':
            sys.exit()
          else:
            self.conduct_search(search, provider)
