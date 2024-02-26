class MinitermFragmentGenerator:
    def __init__(self):
        pass
    
    def generate_fragments(self, predicates):
        fragments = []
        for predicate in predicates:
            fragment = self.generate_miniterm_fragment(predicate)
            fragments.append(fragment)
        return fragments
    
    def generate_miniterm_fragment(self, predicate):
        fragment = "(" + predicate + ")"
        return fragment